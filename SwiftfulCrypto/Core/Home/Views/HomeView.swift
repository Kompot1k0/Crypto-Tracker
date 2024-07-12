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
    
    let manager = ScreenSizeManager.inscance
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
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
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    // show EditPortfolio by press on coin with choosen coin selected
                    .onTapGesture {
                        if isShowPortfolio {
                            withAnimation(.spring()) {
                                vm.updateSelectedCoin(coin: coin)
                                isShowPortfolioView = true
                            }
                        }
                    }
                    // delete coin by swipe
                    .swipeActions(edge: .trailing,
                                  allowsFullSwipe: false,
                                  content: {
                        Button("Delete", role: .destructive, action: {
                            vm.updatePortfolio(coin: coin, amount: 0)
                        })
                    })
            }
        }
        .listStyle(.plain)
    }
    
    private var coinsList: some View {
        Group {
            if !isShowPortfolio {
                allCoinsList
                .transition(.move(edge: .leading))
            } else {
                portfolioCoinsList
                .transition(.move(edge: .trailing))
            }
        }
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if isShowPortfolio {
                Text("Holdings")
            }
            Text("Price")
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
                .environmentObject(dev.vm)
        }
    }
}
