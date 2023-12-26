//
//  File.swift
//  
//
//  Created by Nate Bird on 6/18/23.
//

import Foundation
import Observation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "Quotebook Data", category: "Author")

@Model
public class Author {
    @Attribute(.unique) public var id: String
    public var name: String
    
    @Relationship(deleteRule: .nullify) public var quotes: [Quote]?
    
    public init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}

extension Author {
    static var unknownDescriptor: FetchDescriptor<Author> {
        var descriptor = FetchDescriptor<Author>(sortBy: [SortDescriptor(\.name)])
        descriptor.fetchLimit = 1
        return descriptor
    }
}
