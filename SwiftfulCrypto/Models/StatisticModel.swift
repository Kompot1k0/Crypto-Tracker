//
//  StatisticModel.swift
//  SwiftfulCrypto
//
//  Created by Admin on 09.07.2024.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let persentage: Double?
    
    init(title: String, value: String, persentage: Double? = nil) {
        self.title = title
        self.value = value
        self.persentage = persentage
    }
}
