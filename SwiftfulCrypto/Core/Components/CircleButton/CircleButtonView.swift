//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50)
            .background{
                Circle()
                    .foregroundColor(Color.theme.background)
            }
            .shadow(color: .theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(imageName: "info")
                .previewLayout(.sizeThatFits)
                .padding()
            
            CircleButtonView(imageName: "info")
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
