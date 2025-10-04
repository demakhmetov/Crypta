//
//  CoinDetailView.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import SwiftUI
import Kingfisher
import Charts

struct CoinDetailView: View {
    let itemCoin: CoinModel
    @StateObject private var vm = CoinDetailViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(spacing: 6) {
                Text(itemCoin.currentPrice, format: .currency(code: "USD"))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack(spacing: 4) {
                    Image(systemName: itemCoin.priceChange >= 0 ? "arrow.up.right" : "arrow.down.right")
                    Text("\(itemCoin.priceChange, specifier: "%.2f")%")
                }
                .foregroundStyle(itemCoin.priceChange >= 0 ? .green : .red)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .glassEffect(.regular.tint(itemCoin.priceChange >= 0 ? .green.opacity(0.1) : .red.opacity(0.1)))
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                CoinInfoCard(name: "Rank", item: "#\(itemCoin.rank!)")
                CoinInfoCard(name: "Market cap", item: String(itemCoin.marketCap.formattedCurrency()))
                CoinInfoCard(name: "Price for 24h", item: String(itemCoin.priceFor24Hours.formattedCurrency()))
                CoinInfoCard(name: "Change percentage", item: String(format: "%.2f%%", itemCoin.priceChange))
                CoinInfoCard(name: "High for 24h", item: String(itemCoin.priceHighFor24Hours.formattedCurrency()))
                CoinInfoCard(name: "Low for 24h", item: String(itemCoin.priceLowFor24Hours.formattedCurrency()))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    KFImage(itemCoin.image)
                        .placeholder { ProgressView() }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text(itemCoin.name.truncated(to: 16))
                        .lineLimit(1)
                }
            }
        }
        .task {
            Task {
                await vm.fetchHistory(for: itemCoin.id)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CoinDetailView(itemCoin: CoinModel(id: "bla", name: "test", symbol: "String", image: URL(string: "bLA")!, currentPrice: 118603, priceChange: 3.70, rank: 1, marketCap: 6532612571, priceFor24Hours: 4080.29, priceHighFor24Hours: 119400, priceLowFor24Hours: 114287))
}

struct CoinInfoCard: View {
    var name: String
    var item: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item)
                .font(.title)
                .fontWeight(.bold)
            Text(name)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .glassEffect(in: RoundedRectangle(cornerRadius: 24))
    }
}
