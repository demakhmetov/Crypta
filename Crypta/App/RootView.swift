//
//  RootView.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            CoinsListView()
                .tabItem {
                    Image("CircleStack")
                    Text("Coins")
                }
        }
        .preferredColorScheme(.dark)
        .tint(.pink)
    }
}

#Preview {
    RootView()
}
