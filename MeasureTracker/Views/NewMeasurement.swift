//
//  NewMeasurement.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 05/01/25.
//
import SwiftUI

struct LayoutConstants {
    static let sheetIdealWidth = 400.0
    static let sheetIdealHeight = 700.0
}

struct NewMeasurement: View {
    @Environment(\.dismiss) private var dismiss
    
    private var measured: Measured

    @State private var newMeasurmentSize: Double?
    @State private var newMeasurmentDate: Date = .now
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
    }()
    
    public init(measured: Measured) {
        self.measured = measured
    }
    
    func createNewMeasurment() {
        measured.measures.append(.init(size: newMeasurmentSize ?? 0, measuredDate: newMeasurmentDate))
        dismiss()
    }
    
    var body: some View {
            Form {
                HStack{
                    TextField("Qual foi o valor medido?", value: $newMeasurmentSize, formatter: formatter)
                        .textFieldStyle(.plain)
                        .padding()
                    Text(measured.unit.rawValue)
                }
                DatePicker(
                    "Qual dia foi medido?",
                    selection: $newMeasurmentDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.automatic)
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Adicionar") {
                        createNewMeasurment()
                    }
                }
            }
            .navigationTitle("Add Measured")
    }
}

#Preview {
    NewMeasurement(measured: .init(name: "Corridas", unit: .km, icon: Icon.person.rawValue, color: Color.blue, iconColor: false))
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
