//
//  CoinsViewModel.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import Foundation

@MainActor
class CoinsViewModel: ObservableObject {
    @Published var coins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showErrorAlert: Bool = false
    
    private let service = CoinAPIService()
    
    @discardableResult
    func fetchCoins(mode: FetchMode, isRefresh: Bool = false) async -> Bool {
        if !isRefresh {
            isLoading = true
        }
        
        defer {
            isLoading = false
        }
        
        do {
            let fetchedCoins = try await service.fetchCoins(mode: mode)
            coins = fetchedCoins
            errorMessage = nil
            return true
        } catch {
            if let apiError = error as? APIError {
                errorMessage = apiError.localizedDescription
            } else {
                errorMessage = error.localizedDescription
            }
            showErrorAlert = true
            return false
        }
    }
}
