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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Measurement.self,
            Measured.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
