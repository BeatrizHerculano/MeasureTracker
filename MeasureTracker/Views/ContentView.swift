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
    
    @Query(sort: \Measured.name, order: .forward)
    private var measuredItems: [Measured]
    
    @State private var showAddMeasured = false
    @State var selection: Measured?
    
    
    var body: some View {
        NavigationSplitView {
            NavigationStack{
                List(selection: $selection) {
                    ForEach(measuredItems) { item in
                        MeasuredItem(measured: item)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showAddMeasured = true
                    } label: {
                        Label("Add measured", systemImage: "plus")
                    }
                }
            }
        } detail: {
            if let selection = selection {
                NavigationStack {
                    MeasuredDetails(measured: selection)
                }
            }
        }
        .sheet(isPresented: $showAddMeasured) {
            NavigationStack {
                NewMeasured()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        
        offsets.forEach { index in
            
            let itemToDelete = measuredItems[index]
            
            modelContext.delete(itemToDelete)
            
            
            do {
                try modelContext.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
