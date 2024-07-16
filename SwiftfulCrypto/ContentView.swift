//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Accent Color")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.theme.accent)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Text("Red color")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.theme.red)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Text("Green Color")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.theme.green)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Text("Secondary Text")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.theme.secondaryText)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
