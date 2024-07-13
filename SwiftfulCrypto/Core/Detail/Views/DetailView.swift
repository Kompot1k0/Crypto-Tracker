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
    
    let coin: CoinModel?
    
    var body: some View {
        if let coin = coin {
            VStack {
                Text(coin.name)
                Text(coin.symbol)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
