//
//  ScreenSize.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

class ScreenSize {
    
    static let inscance = ScreenSize()
    private init() {}
    
    func getScreenWidth() -> CGFloat {
        if let screen = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.screen {
            return screen.bounds.width
        }
        return UIScreen.main.bounds.width
    }
    
}
