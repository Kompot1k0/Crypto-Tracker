//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 18.07.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")
    let swiftfulURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")
    let coingeckoURL = URL(string: "https://docs.coingecko.com/reference/introduction")
    let personalGitURL = URL(string: "https://www.google.com")
    let personalDjinniURL = URL(string: "https://www.google.com")
    let personalDouURL = URL(string: "https://dou.ua/users/edik-marrugo/")
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    developerSection
                    aboutSection
                    coingeckoSection
                    applicationSection
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
            }
        }
        
    }
}

extension SettingsView {
    
    private var aboutSection: some View {
        Section(header: Text("About an App")) {
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, CoreData. And includes several improvements deviating from the course😉.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.theme.accent)
                
                if let url = swiftfulURL {
                    Link("Visit SwiftfulThinking", destination: url)
                }
            }
        }
    }
    
    private var coingeckoSection: some View {
        Section(header: Text("Coingecko API")) {
            VStack(alignment: .leading, spacing: 10) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes from a free API, from CoinGecko🦎.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.theme.accent)
                if let url = coingeckoURL {
                    Link("Visit CoinGecko", destination: url)
                }
            }
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading, spacing: 10) {
                //                Image(systemName: "person.fill")
                Image("dev_photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Ed Marrugo. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.theme.accent)
                if let url = personalGitURL {
                    Link("Visit GitHub", destination: url)
                }
                if let url = personalDjinniURL {
                    Link("Visit Djinni", destination: url)
                }
                if let url = personalDouURL {
                    Link("Visit DOU", destination: url)
                }
            }
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            if let url = defaultURL {
                VStack(alignment: .leading, spacing: 10) {
                    Link("Terms of Service", destination: url)
                    Link("Privacy Policy", destination: url)
                    Link("Company Website", destination: url)
                    Link("Learn more", destination: url)
                }
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
