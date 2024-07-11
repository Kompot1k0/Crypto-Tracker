//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Admin on 10.07.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var selectedCoin: CoinModel?
    
    @State private var quantityText: String = ""
    
    @State private var isShowCheckmark: Bool = false
    
    @FocusState private var isShowKeybord: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchBarText: $vm.searchBarText, selectedCoin: $vm.selectedCoin)
                        .focused($isShowKeybord)
                    coinLogoList
                    selectedCoinDetails
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(selectedCoin: .constant(nil))
            .environmentObject(dev.vm)
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack() {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if selectedCoin?.id == coin.id {
                                    selectedCoin = nil
                                    vm.searchBarText = ""
                                } else {
                                    selectedCoin = coin
                                    isShowKeybord = false
                                }
                                quantityText = ""
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private var selectedCoinDetails: some View {
        Group {
            if selectedCoin != nil {
                VStack(spacing: 20) {
                    HStack {
                        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "") is:")
                        Spacer()
                        Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                    }
                    Divider()
                    HStack {
                        Text("Amount in portfolio: ")
                        Spacer()
                        TextField("Ex: 1.4", text: $quantityText)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .focused($isShowKeybord)
                    }
                    Divider()
                    HStack {
                        Text("Current value: ")
                        Spacer()
                        Text(getCurrentValue().asCurrencyWith2Decimals())
                    }
                }
                .padding()
                .animation(.none)
            }
        }
    }
    
    private var saveButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(isShowCheckmark ? 1 : 0)
                .foregroundColor(.theme.green)
            
            Button {
                saveButtopPressed()
            } label: {
                Text("SAVE")
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1 : 0)
        }
    }
    
    private func getCurrentValue() -> Double {
        var result: Double = 0
        
        if let quntity = Double(quantityText) {
            result = quntity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return result
    }
    
    private func saveButtopPressed() {
        
        guard let coin = selectedCoin else { return }
        
        withAnimation(.easeIn) {
            isShowCheckmark = true
            removeSelectedCoin()
            isShowKeybord = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            withAnimation(.easeOut){
                isShowCheckmark = false
            }
        })
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        quantityText = ""
    }
}
