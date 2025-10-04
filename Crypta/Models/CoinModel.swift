//
//  CoinModel.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import Foundation

struct CoinModel: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let image: URL
    let currentPrice: Double
    let priceChange: Double
    let rank: Int?
    let marketCap: Double
    let priceFor24Hours: Double
    let priceHighFor24Hours: Double
    let priceLowFor24Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case currentPrice = "current_price"
        case priceChange = "price_change_percentage_24h"
        case rank = "market_cap_rank"
        case marketCap = "market_cap"
        case priceFor24Hours = "price_change_24h"
        case priceHighFor24Hours = "high_24h"
        case priceLowFor24Hours = "low_24h"
    }
}
