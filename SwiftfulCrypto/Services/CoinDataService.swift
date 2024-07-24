//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Admin on 08.07.2024.
//

/*
 let url = URL(string: "https://pro-api.coingecko.com/api/v3/coins/markets")!
 var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
 let queryItems: [URLQueryItem] = [
   URLQueryItem(name: "vs_currency", value: "usd"),
   URLQueryItem(name: "order", value: "market_cap_desc"),
   URLQueryItem(name: "per_page", value: "250"),
   URLQueryItem(name: "page", value: "1"),
   URLQueryItem(name: "price_change_percentage", value: "24h"),
 ]
 components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

 var request = URLRequest(url: components.url!)
 request.httpMethod = "GET"
 request.timeoutInterval = 10
 request.allHTTPHeaderFields = [
   "accept": "application/json",
   "x-cg-pro-api-key": "CG-jgFNQMbDDEmGDTjDBs7ewQoi"
 ]

 let (data, _) = try await URLSession.shared.data(for: request)
 print(String(decoding: data, as: UTF8.self))
 */

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinsSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinsSubscription = NetworkingManager.download(from: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinsSubscription?.cancel()
            })
    }
    
}
