//
//  CoinDetailViewModel.swift
//  Crypta
//
//  Created by Dias on 02.10.2025.
//

import Foundation

@MainActor
class CoinDetailViewModel: ObservableObject {
    @Published var history: [CoinPricePointModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let service = CoinAPIService()
    
    func fetchHistory(for coinID: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            history = try await service.fetchCoinChart(coinID: coinID)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
