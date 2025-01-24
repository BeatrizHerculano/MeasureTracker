//
//  Item.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 01/10/24.
//

import Foundation
import SwiftData

@Model
final class Measurement: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    var size: Double
    var measured: Measured?
    var measuredDate: Date
    
    init(size: Double, measuredDate: Date = .now) {
        self.size = size
        self.measuredDate = measuredDate
    }
}
