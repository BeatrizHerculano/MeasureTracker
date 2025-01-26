//
//  MeasuredDetails.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 14/10/24.
//

import SwiftUI
import Charts
import SwiftData
import Combine

struct MeasuredDetails: View {
    @Environment(\.modelContext) private var modelContext
    var measured: Measured
    
    var body: some View {
        VStack {
            if !measured.measures.isEmpty   {
                TabView {
                    Tab("Gráfico", systemImage: "chart.xyaxis.line") {
                        Chart(measured.measures) {
                            LineMark(
                                x: .value("Date", $0.measuredDate),
                                y: .value("Measurement", $0.size)
                            )
                            .lineStyle(.init(lineWidth: 5,lineCap: .round, lineJoin: .round))
                            PointMark(
                                x: .value("Date", $0.measuredDate),
                                y: .value("Measurement", $0.size)
                            )
                            .symbolSize(120)
                        }
                        .padding()
                    }
                    
                    Tab("Lista", systemImage: "list.bullet") {
                        List {
                            ForEach(measured.measures){ measure in
                                HStack {
                                    Text(formattedDouble(measure.size))
                                    Text("\(measured.unit)")
                                    Spacer()
                                    Text(formatedDate(date: measure.measuredDate))
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                }
            } else {
                Text("Adicione um item em \(measured.name)")
                NavigationLink {
                    addNewMeasurment()
                } label: {
                    Text("Adicionar Medição")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationStack {
                    NavigationLink {
                        addNewMeasurment()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle(measured.name)
        .navigationBarTitleDisplayMode(.large)
    }
    
    func addNewMeasurment() -> some View {
        NewMeasurement(measured: measured)
    }
    
    func formatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func formattedDouble(_ double: Double) -> String {
        String(format: "%.2f", double)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(measured.measures[index])
            }
        }
    }
}

#Preview {
    MeasuredDetails(measured: .init(name: "Teste de medida", unit: .cm))
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
