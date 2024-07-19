//
//  LaunchView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 19.07.2024.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    @State private var isShowLoadingText: Bool = false
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var cycle: Int = 0
    @Binding var isShowLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if isShowLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(.scale.animation(.easeInOut))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            withAnimation(.linear) {
                isShowLoadingText.toggle()
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.linear) {
                
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    cycle += 1
                    if cycle >= 2 {
                        isShowLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}


struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(isShowLaunchView: .constant(true))
    }
}
