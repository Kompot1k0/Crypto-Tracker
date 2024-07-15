//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Admin on 15.07.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                print("RECIVED COIN DETAIL DATA")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
