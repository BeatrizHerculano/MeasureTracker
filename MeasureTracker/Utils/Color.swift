//
//  Color.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 26/01/25.
//

import SwiftUI

extension Color {
    // Converter para Hexadecimal
    func toHex() -> String? {
        #if canImport(UIKit)
        let uiColor = UIColor(self)
        #elseif canImport(AppKit)
        let uiColor = NSColor(self)
        #else
        return nil
        #endif

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return String(format: "#%02X%02X%02X%02X",
                      Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
    }

    // Inicializar com Hexadecimal
    init?(hex: String) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        guard hexFormatted.count == 6 || hexFormatted.count == 8 else { return nil }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        if hexFormatted.count == 6 {
            self.init(
                red: Double((rgbValue >> 16) & 0xFF) / 255.0,
                green: Double((rgbValue >> 8) & 0xFF) / 255.0,
                blue: Double(rgbValue & 0xFF) / 255.0
            )
        } else {
            self.init(
                red: Double((rgbValue >> 24) & 0xFF) / 255.0,
                green: Double((rgbValue >> 16) & 0xFF) / 255.0,
                blue: Double((rgbValue >> 8) & 0xFF) / 255.0,
                opacity: Double(rgbValue & 0xFF) / 255.0
            )
        }
    }
}
