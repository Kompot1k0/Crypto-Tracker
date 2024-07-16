//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Admin on 08.07.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let inctanse = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(error.localizedDescription)")
        }
        
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path()) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
    
    private func getURLForFolder(_ name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appending(path: name)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName) else { return nil }
        return folderURL.appending(path: imageName + ".png")
    }
    
    private func createFolderIfNeeded(folderName: String) {
        
        guard let url = getURLForFolder(folderName) else { return }
        
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        } catch let error {
            print("Error creating a folder, for FolderName: \(folderName). \(error.localizedDescription)")
        }
        
    }
}
