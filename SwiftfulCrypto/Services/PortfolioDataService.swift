//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Admin on 11.07.2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var coinsInPortfolio: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading CoreData. \(error.localizedDescription)")
            }
        }
        context = container.viewContext
        getPortfolio()
    }
    
    
    // MARK: PUBLIC FUNC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        if let entity = coinsInPortfolio.first(where: { $0.coinID == coin.id}) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE FUNC
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            coinsInPortfolio = try context.fetch(request)
        } catch let error {
            print("Error fetching CoreData. \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: context)
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChanges()
    }
    
    private func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving CoreData. \(error.localizedDescription)")
        }
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        context.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
