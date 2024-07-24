//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var isShowPortfolio: Bool = false // animated right
    @State private var isShowPortfolioView: Bool = false // show sheet
    @State private var isShowSettingsView: Bool = false // show sheet
    
    let manager = ScreenSizeManager.inscance
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $isShowPortfolioView, onDismiss: { vm.selectedCoin = nil }) {
                        PortfolioView(selectedCoin: $vm.selectedCoin, quantityText: $vm.quantityText)
                            .environmentObject(vm)
                    }
                
                // foreground
                VStack {
                    homeHeader
                    
                    HomeStatView(isShowPortfolio: $isShowPortfolio)
                    
                    SearchBarView(searchBarText: $vm.searchBarText, selectedCoin: $vm.selectedCoin)
                    
                    columnTitles
                    
                    coinsList
                    
                    Spacer(minLength: 0)
                }
                .sheet(isPresented: $isShowSettingsView) {
                    SettingsView()
                }
            }
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        VStack {
            HStack {
                CircleButtonView(imageName: isShowPortfolio ? "plus" : "info")
                    .onTapGesture {
                        if isShowPortfolio {
                            withAnimation(.spring()) {
                                isShowPortfolioView = true
                            }
                        } else {
                            withAnimation(.spring()) {
                                isShowSettingsView = true
                            }
                        }
                    }
                
                    .animation(.none, value: isShowPortfolio)
                    .background(CircleButtonAnimationView(animate: $isShowPortfolio))
                
                Spacer()
                
                Text(isShowPortfolio ? "Portfolio" : "Live Prices")
                    .animation(.none, value: isShowPortfolio)
                
                Spacer()
                
                CircleButtonView(imageName: "chevron.right")
                    .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isShowPortfolio.toggle()
                        }
                    }
            }
            .padding()
        }
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                NavigationLink(value: coin) {
                    CoinRowView(coin: coin, showHoldingColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(.plain)
        .refreshable {
            withAnimation(.linear) {
                vm.reloadData()
            }
        }
        .navigationDestination(for: CoinModel.self, destination: { coin in
            DetailView(coin: coin) })
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        // show EditPortfolio by press on coin with choosen coin selected
                        if isShowPortfolio {
                            withAnimation(.spring()) {
                                vm.selectedCoin = coin
                                isShowPortfolioView = true
                            }
                        }
                    }
                // delete coin by swipe
                    .swipeActions(edge: .trailing,
                                  allowsFullSwipe: false,
                                  content: {
                        Button("Delete", role: .destructive, action: {
                            withAnimation() {
                                vm.updatePortfolio(coin: coin, amount: 0)
                            }
                        })
                    })
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(.plain)
    }
    
    private var coinsList: some View {
        Group {
            if !isShowPortfolio {
                allCoinsList
                    .transition(.move(edge: .leading))
            } else {
                ZStack {
                    if vm.portfolioCoins.isEmpty && vm.searchBarText.isEmpty {
                        portfolioIsEmptyText
                            .transition(.opacity)
                    } else {
                        portfolioCoinsList
                    }
                }
                .transition(.move(edge: .trailing))
            }
        }
    }
    
    private var portfolioIsEmptyText: some View {
        VStack {
            Spacer()
            Text("""
                    You haven't coins in portfolio et.
                    Click ➕ to add some😉
                    """)
            .font(.title)
            .foregroundColor(.theme.accent)
            .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.linear) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if isShowPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.linear) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.linear) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            .frame(width: manager.getScreenWidth() / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(dev.vm)
    }
}
