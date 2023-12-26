//
//  Tag+DataGeneration.swift
//
//
//  Created by Nate Bird on 10/18/23.
//

import Foundation
import SwiftData

extension Tag {
    static func generateAll(modelContext: ModelContext) {        
        let allTagContent: [String] = [
            "eleanor was right",
            "bring it",
            "who's the boss",
            "100",
            "funny",
            "lol",
            "church",
        ]
        
        for content in allTagContent {
            generateTag(content)
        }
        
        func generateTag(_ name: String) {
            let tag = Tag(name: name)
            modelContext.insert(tag)
        }
    }
}
