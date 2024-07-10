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
        HStack {
            ForEach(vm.stat) { stat in
                StatisticBarView(stat: stat)
                    .frame(width: ScreenSizeManager.inscance.getScreenWidth() / 3)
            }
        }
        .frame(width: ScreenSizeManager.inscance.getScreenWidth(),
               alignment: isShowPortfolio ? .trailing : .leading)
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView(isShowPortfolio: .constant(false))
            .environmentObject(HomeViewModel())
    }
}
