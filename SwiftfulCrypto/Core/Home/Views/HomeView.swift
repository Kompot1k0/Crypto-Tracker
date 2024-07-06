//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var isShowPortfolio: Bool = false
    
    let manager = ScreenSizeManager.inscance
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
            
            // foreground
            VStack {
                homeHeader
                
                columnTitles
                
                if !isShowPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList
                    .transition(.move(edge: .trailing))
                }
                
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
            }
        }
        .listStyle(.plain)
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
