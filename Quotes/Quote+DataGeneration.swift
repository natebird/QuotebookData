//
//  File.swift
//  
//
//  Created by Nate Bird on 6/18/23.
//

import Foundation
import SwiftData

extension Quote {
    static func generateAll(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 1)
        
        let allAuthors = try! modelContext.fetch(FetchDescriptor<Author>(sortBy: [.init(\.id)]))
        let allTagNames = try! modelContext.fetch(FetchDescriptor<Tag>(sortBy: [.init(\.id)]))
        let allQuoteContent: [String] = [
            "Just Do It",
            "Maywagge is what brings us twogether tdway.",
            "@Tiffany: Who's the boss in the family?\n@Eleanor: I'm the boss!",
            "What a computer is to me is it’s the most remarkable tool that we’ve ever come up with, and it’s the equivalent of a bicycle for our minds.",
            "Don’t let the noise of others’ opinions drown out your own inner voice.",
            "I don't need to sleep anymore.",
            "Are you sure about this?",
        ]
        
        for content in allQuoteContent {
            generateQuote(content)
        }
        
        func generateQuote(_ content: String) {
            guard let author = allAuthors.randomElement() else { return }
            guard let tag = allTagNames.randomElement() else { return }
            let isFavorite = Int.random(in: 0..<9, using: &random).isMultiple(of: 2)
            let quote = Quote(content: content, timestamp: Date.now, isFavorite: isFavorite)

            modelContext.insert(quote)
            quote.authors.append(author)
            quote.tags.append(tag)
        }
    }
}
