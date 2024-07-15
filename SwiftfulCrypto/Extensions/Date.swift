//
//  Date.swift
//  SwiftfulCrypto
//
//  Created by Admin on 15.07.2024.
//

import Foundation

extension Date {
    
    // 2024-04-07T16:49:31.736Z
    init(apiDateString: String) {
        let forrmater = DateFormatter()
        forrmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = forrmater.date(from: apiDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortForrmater: DateFormatter {
        let forrmater = DateFormatter()
        forrmater.dateStyle = .short
        return forrmater
    }
    
    func asShortDateString() -> String {
        return shortForrmater.string(from: self)
    }
    
}
