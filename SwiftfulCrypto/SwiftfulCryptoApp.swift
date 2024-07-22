//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Admin on 06.07.2024.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var isShowLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.green
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden)
                }
                .environmentObject(vm)
                
                ZStack {
                    if isShowLaunchView {
                        LaunchView(isShowLaunchView: $isShowLaunchView)
                            .transition(.move(edge: .bottom))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
