//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 12.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    
    @State private var showFullDescription: Bool = false
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
                .ignoresSafeArea()
            
            // foreground
            ScrollView {
                ChartView(coin: vm.coin)
                VStack(spacing: 20) {
                    overview
                    Divider()
                    description
                    Divider()
                    additionalDetails
                    websiteLinks
                }
                .padding()
            }
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
    
    private var description: some View {
        Group {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                        .lineLimit(showFullDescription ? nil : 3)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less..." : "Read More...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private var websiteLinks: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                if let websiteString = vm.webSiteURL,
                   let url = URL(string: websiteString) {
                    Link("Website", destination: url)
                }
                
                if let forumString = vm.forumURL,
                   let url = URL(string: forumString) {
                    Link("Forum", destination: url)
                }
            }
            .tint(.blue)
            .font(.caption)
            
            Spacer()
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
