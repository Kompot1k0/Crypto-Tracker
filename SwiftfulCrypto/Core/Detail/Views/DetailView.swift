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
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        VStack {
            Text("tmp")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
