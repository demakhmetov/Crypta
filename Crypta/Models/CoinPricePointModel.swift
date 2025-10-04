//
//  CoinPricePointModel.swift
//  Crypta
//
//  Created by Dias on 02.10.2025.
//

import Foundation

struct CoinPricePointModel: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let price: Double
    
    init(date: Date, price: Double) {
        self.date = date
        self.price = price
    }
}
