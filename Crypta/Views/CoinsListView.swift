//
//  CoinsListView.swift
//  Crypta
//
//  Created by Dias on 29.09.2025.
//

import SwiftUI

struct CoinsListView: View {
    @StateObject var vm = CoinsViewModel()
    @State private var path: [CoinModel] = []
    @State private var showSearch: Bool = false
    @State private var selectedMode: FetchMode = .top
    @State private var isLoaded: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Picker("Mode", selection: $selectedMode) {
                    Text("Top").tag(FetchMode.top)
                    Text("Trending").tag(FetchMode.trending)
                }
                .disabled(vm.errorMessage != nil || vm.isLoading)
                .pickerStyle(.palette)
                .padding(.horizontal)
                .onChange(of: selectedMode) { oldValue, newValue in
                    Task {
                        if (vm.errorMessage == nil) {
                            let isSuccess = await vm.fetchCoins(mode: newValue)
                            if !isSuccess {
                                selectedMode = oldValue
                            }
                        }
                    }
                }

                List {
                    Section {
                        ForEach(vm.coins) { item in
                            Button {
                                path.append(item)
                            } label: {
                                CoinsRowView(coin: item)
                            }
                        }
                    }
                    .listSectionSeparator(.hidden)
                }
                .refreshable {
                    await vm.fetchCoins(mode: selectedMode, isRefresh: true)
                }
            }
            .alert("Error", isPresented: $vm.showErrorAlert) {
                Button("OK") {}
            } message: {
                Text(vm.errorMessage ?? "Idk")
            }
            .overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .navigationDestination(for: CoinModel.self) { coin in
                CoinDetailView(itemCoin: coin)
            }
            .listStyle(.plain)
            .toolbar() {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(alignment: .center, spacing: 3) {
                        Image("CurrencyLogo")
                            .foregroundStyle(.pink)
                        Text("Crypta")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .kerning(-0.5)
                    }
                    .fixedSize()
                    .iOS26Only { view in
                        view.padding(.horizontal, 12)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSearch = true
                    } label: {
                        Image("MagnifyingGlass")
                            .foregroundStyle(.white)
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                CoinsSearchView(showSearch: $showSearch, coins: vm.coins) { selectedCoin in
                    showSearch = false
                    path.append(selectedCoin)
                }
                .padding(.top, 24)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
        .task {
            if (!isLoaded) {
                await vm.fetchCoins(mode: selectedMode)
                isLoaded = true
            }
        }
    }
}

#Preview {
    CoinsListView()
}
