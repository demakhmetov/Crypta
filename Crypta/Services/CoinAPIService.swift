//
//  CoinAPIService.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import Foundation

enum FetchMode {
    case top
    case trending
}

protocol CoinAPIServiceProtocol {
    func fetchCoins(mode: FetchMode) async throws -> [CoinModel]
}

class CoinAPIService: CoinAPIServiceProtocol {
    func fetchCoins(mode: FetchMode) async throws -> [CoinModel] {
        var components = URLComponents(string: "https://api.coingecko.com/api/v3/coins/markets")!
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "per_page", value: "100"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "false")
        ]
        
        switch mode {
        case .top:
            components.queryItems?.append(URLQueryItem(name: "order", value: "market_cap_desc"))
        case .trending:
            components.queryItems?.append(URLQueryItem(name: "order", value: "volume_desc"))
        }
        
        guard let url = components.url else {
            throw APIError.unknown
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200:
            break
        case 429:
            throw APIError.rateLimited
        default:
            throw APIError.network
        }
        
        do {
            let decodedCoins = try JSONDecoder().decode([CoinModel].self, from: data)
            return decodedCoins
        } catch {
            throw APIError.decoding
        }
    }
    
    func fetchCoinChart(coinID: String) async throws -> [CoinPricePointModel] {
        var components = URLComponents(string: "https://api.coingecko.com/api/v3/coins/\(coinID)/market_chart")!
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "days", value: "1")
        ]
        
        guard let url = components.url else {
            throw APIError.unknown
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200:
            break
        case 429:
            throw APIError.rateLimited
        default:
            debugPrint(httpResponse.url)
            throw APIError.network
        }
        
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        guard let prices = json?["prices"] as? [[Any]] else {
            throw APIError.decoding
        }
        
        return prices.compactMap { arr in
            guard let timestamp = arr[0] as? Double,
                  let price = arr[1] as? Double else { return nil }
            return CoinPricePointModel(
                date: Date(timeIntervalSince1970: timestamp / 1000),
                price: price
            )
        }
    }
}
