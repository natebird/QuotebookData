//
//  File.swift
//  
//
//  Created by Nate Bird on 6/18/23.
//

import Observation
import Foundation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "QuotebookData", category: "Account")

@Model public class Account {
    @Attribute(.unique) public var id: String
    public var joinDate: Date
    public var displayName: String
    public var emailAddress: String
    public var isPremiumMember: Bool

    public init(joinDate: Date, displayName: String, emailAddress: String, isPremiumMember: Bool) {
        self.id = UUID().uuidString
        self.joinDate = joinDate
        self.displayName = displayName
        self.emailAddress = emailAddress
        self.isPremiumMember = isPremiumMember
        logger.notice("User \(self.id) has been created with DisplayName: '\(self.displayName)' and is \(self.isPremiumMember ? "" : "not ")a premium user.")
    }
}
