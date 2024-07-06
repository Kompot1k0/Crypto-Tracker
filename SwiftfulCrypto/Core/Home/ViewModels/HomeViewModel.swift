//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.allCoins.append(DeveloperPreview.instanse.coin)
            self.portfolioCoins.append(DeveloperPreview.instanse.coin)
        })
    }
}
