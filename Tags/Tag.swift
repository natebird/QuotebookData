//
//  File.swift
//  
//
//  Created by Nate Bird on 10/18/23.
//

import Foundation
import Observation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "Quotebook Data", category: "Tag")

@Model public class Tag {
    @Attribute(.unique) public var id: String
    public var name: String
    
    @Relationship var quotes: [Quote]?

    public init(id: UUID = UUID(), name: String) {
        self.id = id.uuidString
        self.name = name
    }
}
