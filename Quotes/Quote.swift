//
//  Quote.swift
//
//
//  Created by Nate Bird on 6/18/23.
//

import Foundation
import Observation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "Quotebook Data", category: "Quote")

@Model public class Quote {
    @Attribute(.unique) public var id: String
    public var content: String
    public var timestamp: Date
    public var notes: String?
    public var source: String?
    public var isFavorite: Bool = false
    
    @Relationship(inverse: \Author.quotes) public var authors: [Author] = []
    @Relationship(inverse: \Tag.quotes) public var tags: [Tag] = []
    
    @Transient
    public var authorsNames: String {
        let authorNamesArray = authors.compactMap { $0.name }
        if authorNamesArray.isEmpty {
            return "Unknown"
        } else {
            return authorNamesArray.joined(separator: ", ")
        }
    }
    
    public var formattedDate: String {
        timestamp.formatted(date: .long, time: .omitted)
//        timestamp.formatted(date: .abbreviated, time: .shortened)
    }
    
    public init(id: UUID = UUID(), content: String, timestamp: Date, notes: String? = nil, source: String? = nil, isFavorite: Bool) {
        self.id = id.uuidString
        self.content = content
        self.timestamp = timestamp
        self.notes = notes
        self.source = source
        self.isFavorite = isFavorite
    }
}

extension Quote {
    static public var defaultQuote = Quote(content: "", timestamp: Date.now, isFavorite: false)
}
