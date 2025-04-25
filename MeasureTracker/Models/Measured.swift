//
//  Measured.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 01/10/24.
//

import Foundation
import SwiftData
import SwiftUI

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
    var icon: String
    var color: String
    var iconColor: Bool
    
    init(name: String, unit: Units, icon: String, color: Color, iconColor: Bool) {
        self.name = name
        self.unit = unit
        self.color = color.toHex() ?? "#000000"
        self.iconColor = iconColor
        self.icon = icon
    }
    
    func getIconColor() -> Color {
        iconColor ? .white : .black
    }
}

extension Measured {
    
}
