//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 12.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
