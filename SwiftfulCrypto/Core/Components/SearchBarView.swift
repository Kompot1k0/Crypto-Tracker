//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 09.07.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var SearchBarText: String
    @FocusState private var fieldInFocus: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(SearchBarText.isEmpty ?  .theme.secondaryText : .theme.accent)
                .animation(.default, value: SearchBarText)
            
            TextField("Search by name or symbol...", text: $SearchBarText)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled(true)
                .focused($fieldInFocus)
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
                .foregroundColor(SearchBarText.isEmpty ? .clear : .theme.accent)
                .padding()
                .onTapGesture {
                    SearchBarText = ""
                    fieldInFocus = false
                }
                .animation(.easeIn, value: SearchBarText)
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(SearchBarText: .constant(""))
    }
}
