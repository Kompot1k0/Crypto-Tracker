//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 12.07.2024.
//

import SwiftUI

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
            ChartView(coin: vm.coin)
            VStack(spacing: 20) {
                overview
                Divider()
                additionalDetails
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        Group {
            HStack {
                Text(vm.coin.symbol)
                    .font(.headline)
                    .foregroundColor(.theme.secondaryText)
                CoinImageView(coin: vm.coin)
                    .frame(width: 25, height: 25)
            }
        }
    }
    
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
