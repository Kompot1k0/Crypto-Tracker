//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var stat: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchBarText: String = ""
    @Published var quantityText: String = ""
    
    @Published var selectedCoin: CoinModel? = nil
    
    @Published var sortOption: SortOption = .rank
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, price, priceReversed, holdings, holdingsReversed
    }
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        // updates allCoins
        $searchBarText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortedCoins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates stat
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map (mapGlobalMarketData)
            .sink { [weak self] returnedData in
                self?.stat = returnedData
            }
            .store(in: &cancellables)
        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$coinsInPortfolio)
            .map(mapPortfolioData)
            .sink { [weak self] returnedData in
                guard let self = self else { return }
                self.portfolioCoins = self.sortCoinsIfNeeded(coins: returnedData)
            }
            .store(in: &cancellables)
    }
    
    // MARK: FUNCs
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
        quantityText = ""
    }
    
    func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = portfolioCoins.first(where: { $0.id == coin.id} ),
           let amount = portfolioCoin.currentHoldings {
            quantityText = String(amount)
        } else {
            quantityText = ""
        }
    }
    
    func reloadData() {
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.shared.notification(type: .success)
    }
    
    // MARK: PRIVATE FUNCs
    
    private func filterAndSortedCoins(text: String, startingCoins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, startingCoins: startingCoins)
        sortCoins(sort: sort, coins: &updatedCoins)
        
        return updatedCoins
    }
    
    private func filterCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else {
            return startingCoins
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredText = startingCoins.filter { $0.name.lowercased().contains(lowercasedText) || $0.symbol.lowercased().contains(lowercasedText) || $0.id.lowercased().contains(lowercasedText) }
        
        return filteredText
        
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank } )
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank } )
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice } )
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice } )
        }
    }
    
    private func sortCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        
        var result: [CoinModel] = coins
        
        switch sortOption {
        case .holdings:
            result = coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue } )
        case .holdingsReversed:
            result = coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue } )
        default:
            break
        }
        
        return result
    }
    
    private func mapGlobalMarketData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        
        var stat: [StatisticModel] = []

        guard let data = data else { return stat }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, persentage: data.marketCapChangePercentage24HUsd)
        let totalVolume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value",
                                       value: portfolioValue.asCurrencyWith2Decimals(),
                                       persentage: percentageChange)

        stat.append(contentsOf: [
            marketCap,
            totalVolume,
            btcDominance,
            portfolio
        ])

        return stat
    }
    
    private func mapPortfolioData(allCoinsData: [CoinModel], portfolioData: [PortfolioEntity]) -> [CoinModel] {
        var coins: [CoinModel] = []
        
        coins = allCoinsData.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioData.first(where: { $0.coinID == coin.id} ) else { return nil }
            
            return coin.updateCurrentHoldings(amount: entity.amount)
        }
        
        return coins
    }
    
}
