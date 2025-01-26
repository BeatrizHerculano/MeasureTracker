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
    
    @State var selection: Measured?
    
    var body: some View {
        NavigationSplitView {
            NavigationStack{
                List(selection: $selection) {
                    ForEach(measuredItems) { item in
                        NavigationLink(value: item) {
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
            if let selection = selection {
                NavigationStack {
                    MeasuredDetails(measured: selection)
                }
            }
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
}
