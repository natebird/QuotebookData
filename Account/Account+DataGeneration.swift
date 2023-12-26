//
//  File.swift
//  
//
//  Created by Nate Bird on 6/18/23.
//

import Foundation
import OSLog
import SwiftData

private let logger = Logger(subsystem: "QuotebookData", category: "Account Generation")

extension Account {
    static func generateAccount(modelContext: ModelContext) {
        logger.info("Generating/Fetching Account")
        
        let date = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 5, hour: 9, minute: 41))!
        let account = Account(
            joinDate: date,
            displayName: "Nate Bird",
            emailAddress: "nate.bird@mac.com",
            isPremiumMember: true
        )
        modelContext.insert(account)
        
        logger.info("Finished Generating/Fetching Account")
    }
}
