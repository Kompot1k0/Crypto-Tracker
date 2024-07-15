//
//  ChartView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 15.07.2024.
//

import SwiftUI

struct ChartView: View {
    
    @State private var lineAnimation: CGFloat = 0
    
    private let data: [Double]
    
    private let maxY: Double
    private let minY: Double
    
    private let lineColor: Color
    
    private let rightDate: Date
    private let leftDate: Date
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        rightDate = Date(apiDateString: coin.lastUpdated ?? "")
        leftDate = rightDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chart
                .frame(height: 200)
                .background(chartBackground)
                .overlay(alignment: .leading) {
                    chartLeftSidePrice
                        .padding(.horizontal, 4)
                }
            chartBottomDates
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1.7)){
                    lineAnimation = 1
                }
            }
        }
    }
}

extension ChartView {
    
    private var chart: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: lineAnimation)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.7), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartLeftSidePrice: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartBottomDates: some View {
        HStack {
            Text(rightDate.asShortDateString())
            Spacer()
            Text(leftDate.asShortDateString())
        }
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
