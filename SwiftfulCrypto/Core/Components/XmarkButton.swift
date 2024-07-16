//
//  XmarkButton.swift
//  SwiftfulCrypto
//
//  Created by Admin on 10.07.2024.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.theme.accent)
        }
    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
