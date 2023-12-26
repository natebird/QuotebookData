//
//  DataGeneration.swift
//  
//
//  Created by Nate Bird on 6/18/23.
//

import Observation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "QuotebookData", category: "DataGeneration")

// MARK: - Data Generation

@Model public class DataGeneration {
    public var initializationDate: Date?
    public var lastSimulationDate: Date?
        
    @Transient public var requiresInitialDataGeneration: Bool {
        initializationDate == nil
    }
    
    public init(initializationDate: Date?, lastSimulationDate: Date?) {
        self.initializationDate = initializationDate
        self.lastSimulationDate = lastSimulationDate
    }
    
    private func simulateHistoricalEvents(modelContext: ModelContext) {
        logger.info("Attempting to simulate historical events...")
        if requiresInitialDataGeneration {
            logger.info("Requires an initial data generation")
            generateInitialData(modelContext: modelContext)
        }
    }
    
    private func generateInitialData(modelContext: ModelContext) {
        logger.info("Generating initial data...")
        
        // First, generate all available bird food, bird species, and plant species.
        logger.info("Generating all authors")
        Author.generateAll(modelContext: modelContext)

        logger.info("Generating all tags")
        Tag.generateAll(modelContext: modelContext)

        logger.info("Generating all quotes")
        Quote.generateAll(modelContext: modelContext)
                
        logger.info("Generating account")
        // The app content is complete, now it's time to create the person's account.
        Account.generateAccount(modelContext: modelContext)
        
        logger.info("Completed generating initial data")
        initializationDate = .now
    }
    
    private static func instance(with modelContext: ModelContext) -> DataGeneration {
        if let result = try! modelContext.fetch(FetchDescriptor<DataGeneration>()).first {
            return result
        } else {
            let instance = DataGeneration(
                initializationDate: nil,
                lastSimulationDate: nil
            )
            modelContext.insert(instance)
            return instance
        }
    }
    
    public static func generateAllData(modelContext: ModelContext) {
        let instance = instance(with: modelContext)
        logger.info("Attempting to statically simulate historical events...")
        instance.simulateHistoricalEvents(modelContext: modelContext)
    }
}

public extension DataGeneration {
    static let container = try! ModelContainer(for: schema, configurations: [.init(isStoredInMemoryOnly: DataGenerationOptions.inMemoryPersistence)])
    
    static let schema = SwiftData.Schema([
        DataGeneration.self,
        Account.self,
        Quote.self,
        Author.self,
    ])
}
