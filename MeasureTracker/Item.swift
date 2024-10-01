//
//  Item.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 01/10/24.
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
