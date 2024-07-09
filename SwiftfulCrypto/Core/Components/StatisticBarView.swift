//
//  StatisticBarView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 09.07.2024.
//

import SwiftUI

struct StatisticBarView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
            
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.persentage ?? 0) >= 0 ? 0 : 180))
                                    
                Text(stat.persentage?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.persentage ?? 0) >= 0 ? .theme.green : .theme.red)
            .opacity(stat.persentage == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticBarView(stat: dev.stat1)
            
            StatisticBarView(stat: dev.stat3)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
