//
//  Measured.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 01/10/24.
//

import Foundation
import SwiftData

@Model
final class Measured: Identifiable {
    enum Units: String, Codable, CaseIterable, Identifiable {
        var id: Units { self }
        case mm
        case cm
        case m
        case km
    }
    
    @Attribute(.unique) var name: String
    
    @Relationship(deleteRule: .cascade, inverse:\Measurement.measured)
    var measures: [Measurement] = []
    var unit: Units
    
    init(name: String, unit: Units) {
        self.name = name
        self.unit = unit
    }
}
