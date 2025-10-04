//
//  CoinsSearchView.swift
//  Crypta
//
//  Created by Dias on 30.09.2025.
//

import SwiftUI
import Kingfisher

struct CoinsSearchView: View {
    @Binding var showSearch: Bool
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    let coins: [CoinModel]
    var onCoinSelected: (CoinModel) -> Void
    
    var filteredCoins: [CoinModel] {
        if searchText.isEmpty { return coins }
        return coins.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                if #available(iOS 26.0, *) {
                    HStack(spacing: 5) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .focused($isSearchFocused)
                    }
                    .padding(10)
                    .glassEffect()
                } else {
                    // Fallback on earlier versions
                }
                
                Button("Cancel") {
                    showSearch = false
                }
            }
            .padding(.horizontal)
            
            List(filteredCoins) { coin in
                Button {
                    onCoinSelected(coin)
                } label: {
                    HStack {
                        KFImage(coin.image)
                            .placeholder { ProgressView() }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 4)
                        Text(coin.name)
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            isSearchFocused = true
        }
    }
}
