//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var stat: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", persentage: 23.5),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", persentage: -0.07)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchBarText: String = ""
    
    @Published var selectedCoin: CoinModel? = nil
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        // updates allCoins
        $searchBarText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map (mapGlobalMarketData)
            .sink { [weak self] returnedData in
                self?.stat = returnedData
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else {
            return startingCoins
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredText = startingCoins.filter { $0.name.lowercased().contains(lowercasedText) || $0.symbol.lowercased().contains(lowercasedText) || $0.id.lowercased().contains(lowercasedText) }
        
        return filteredText
        
    }
    
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        
        var stat: [StatisticModel] = []

        guard let data = data else { return stat }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, persentage: data.marketCapChangePercentage24HUsd)
        let totalVolume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", persentage: 0)

        stat.append(contentsOf: [
            marketCap,
            totalVolume,
            btcDominance,
            portfolio
        ])

        return stat
    }
    
}
