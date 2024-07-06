//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
            
            // foreground
            homeHeader
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        VStack {
            HStack {
                CircleButtonView(imageName: isShowPortfolio ? "plus" : "info")
                    .animation(.none, value: isShowPortfolio)
                    .background(CircleButtonAnimationView(animate: $isShowPortfolio))
                
                Spacer()
                
                Text(isShowPortfolio ? "Portfolio" : "Live Prices")
                    .animation(.none, value: isShowPortfolio)
                
                Spacer()
                
                CircleButtonView(imageName: "chevron.right")
                    .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isShowPortfolio.toggle()
                        }
                    }
            }
            .padding()
            
            Spacer(minLength: 0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden)
        }
    }
}
