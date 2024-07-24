//
//  CoinRowView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    let manager = ScreenSizeManager.inscance
    
    var body: some View {
        HStack(spacing: 0) {
            leftPart
            Spacer()
            if showHoldingColumn {
                centerPart
            }
            rightPart
        }
        .font(.subheadline)
        .background(Color.theme.background.opacity(0.001))
        .listRowBackground(Color.theme.background)
    }
}

extension CoinRowView {
    
    private var leftPart: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(6)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerPart: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
    
    private var rightPart: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ?
                                 Color.theme.green : Color.theme.red)
        }
        .frame(width: manager.getScreenWidth() / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
    }
}
