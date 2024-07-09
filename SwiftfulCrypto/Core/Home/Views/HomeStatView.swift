//
//  HomeStatView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 09.07.2024.
//

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var isShowPortfolio: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(vm.stat) { stat in
                    StatisticBarView(stat: stat)
                        .frame(width: geometry.size.width / 3)
                }
            }
            .frame(width: geometry.size.width,
                   alignment: isShowPortfolio ? .trailing : .leading)
        }
        .frame(height: 50)
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView(isShowPortfolio: .constant(false))
            .environmentObject(HomeViewModel())
    }
}
