//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Admin on 16.07.2024.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
