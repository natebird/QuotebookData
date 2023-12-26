//
//  File.swift
//  
//
//  Created by Nate Bird on 6/18/23.
//

import Foundation
import SwiftData

extension Author {
    static func generateAll(modelContext: ModelContext) {        
        let allAuthorNames: [String] = [
            "Tiffany Bird",
            "Eleanor Bird",
            "Makenzie Bird",
            "Lorelai Bird",
            "Steve Jobs",
            "Nate Bird",
            "The Pope"
        ]
        
        for name in allAuthorNames {
            let author = Author(name: name)
            modelContext.insert(author)
        }
    }
}
