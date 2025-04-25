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
    @Environment(\.dismiss) private var dismiss
    @Bindable var measured: Measured
    @State var showAddMeasurement = false
    
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
                            .foregroundStyle(Color(hex: measured.color) ?? .blue)
                            PointMark(
                                x: .value("Date", $0.measuredDate),
                                y: .value("Measurement", $0.size)
                            )
                            .foregroundStyle(Color(hex: measured.color) ?? .blue)
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
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color(hex: measured.color) ?? .blue)
                    .overlay {
                        Image(systemName: measured.icon)
                            .resizable()
                            .padding(2)
                            .frame(width: 80, height: 80)
                            .foregroundColor(measured.getIconColor())
                    }
                
                    
                Text("Clique no + para adicionar")
                    .font(.title2)
            }
        }
        .toolbar {
            ToolbarItem {
                NavigationStack {
                    Button {
                        showAddMeasurement = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle(measured.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddMeasurement) {
            NavigationStack {
                NewMeasurement(measured: measured)
            }
            .presentationDetents([.medium, .large])
        }
        
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
            measured.measures.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    MeasuredDetails(measured: .init(name: "Teste de medida", unit: .cm, icon: Icon.folder.rawValue, color: Color.blue, iconColor: false))
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
