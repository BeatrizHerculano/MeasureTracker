//
//  ContentView.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 01/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var measuredItems: [Measured]
    
    var body: some View {
        NavigationSplitView {
            NavigationStack{
                List {
                    ForEach(measuredItems) { item in
                        NavigationLink(destination: MeasuredDetails(measured: item)) {
                            Text(item.name)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink {
                        NewMeasured()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(measuredItems[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
