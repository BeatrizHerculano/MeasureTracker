//
//  MeasureTrackerApp.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 01/10/24.
//

import SwiftUI
import SwiftData

@main
struct MeasureTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(DataModel.shared.modelContainer)
    }
}


actor DataModel {
    struct TransactionAuthor {
        static let widget = "widget"
    }

    static let shared = DataModel()
    private init() {}
    
    nonisolated lazy var modelContainer: ModelContainer = {
        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer(for: Measured.self)
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }
        return modelContainer
    }()
}
