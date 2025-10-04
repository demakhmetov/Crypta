//
//  CoinsRowView.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import SwiftUI
import Kingfisher

struct CoinsRowView: View {
    let coin: CoinModel

    var body: some View {
        HStack {
            KFImage(coin.image)
                .placeholder { ProgressView() }
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(.trailing, 6)
            
            VStack(alignment: .leading) {
                Text(coin.name)
                    .fontWeight(.medium)
                Text(coin.symbol.uppercased())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()

            VStack(alignment: .trailing) {
                Text(coin.currentPrice, format: .currency(code: "USD"))
                
                HStack(spacing: 4) {
                    Image(systemName: coin.priceChange >= 0 ? "arrow.up.right" : "arrow.down.right")
                    Text("\(coin.priceChange, specifier: "%.2f")%")
                }
                .font(.footnote)
                .foregroundStyle(coin.priceChange >= 0 ? .green : .red)
            }
        }
    }
}
