//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 09.07.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchBarText: String
    @Binding var selectedCoin: CoinModel?
    
    @FocusState private var searchBarFieldInFocus: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchBarText.isEmpty ?  .theme.secondaryText : .theme.accent)
                .animation(.default, value: searchBarText)
            
            TextField("Search by name or symbol...", text: $searchBarText)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled(true)
                .focused($searchBarFieldInFocus)
        }
        .font(.headline)
        .padding()
        .background {
            Capsule()
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.15),
                        radius: 10,
                        x: 0, y: 0)
        }
        .overlay(alignment: .trailing) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(searchBarText.isEmpty ? .clear : .theme.accent)
                .padding()
                .onTapGesture {
                    searchBarText = ""
                    selectedCoin = nil
                    searchBarFieldInFocus = false
                }
                .animation(.easeIn, value: searchBarText)
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchBarText: .constant(""), selectedCoin: .constant(nil))
    }
}
