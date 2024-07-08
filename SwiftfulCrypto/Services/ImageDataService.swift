//
//  ImageDataService.swift
//  SwiftfulCrypto
//
//  Created by Admin on 08.07.2024.
//

import Foundation
import Combine
import SwiftUI

class ImageDataService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        downloadImage()
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(from: url)
            .tryMap({ data in
                UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
