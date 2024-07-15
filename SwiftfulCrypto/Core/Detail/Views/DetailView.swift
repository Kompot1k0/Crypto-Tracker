//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 12.07.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    let coin: CoinModel?
    
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hiu")
                    .frame(height: 150)
                    .background(Color.indigo)
                overview
                Divider()
                additionalDetails
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

extension DetailView {
    private var overview: some View {
        Group {
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: nil,
                      pinnedViews: []) {
                ForEach(vm.overviewStat) { stat in
                    StatisticBarView(stat: stat)
                }
            }
        }
    }
    
    private var additionalDetails: some View {
        Group {
            Text("Additional Details")
                .font(.title)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: nil,
                      pinnedViews: []) {
                ForEach(vm.additionalStat) { stat in
                    StatisticBarView(stat: stat)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
