//
//  Item.swift
//  TestNotesApp
//
//  Created by David Carlson on 8/22/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
