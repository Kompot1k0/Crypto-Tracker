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
    private let fileManager = LocalFileManager.inctanse
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getImage()
    }
    
    private func getImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(from: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ data in
                UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                self.imageSubscription?.cancel()
            })
    }
}
