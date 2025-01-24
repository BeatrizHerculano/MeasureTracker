//
//  NewMeasurement.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 05/01/25.
//
import SwiftUI

struct NewMeasurement: View {
    @Environment(\.modelContext) private var modelContext
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
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Medir Algo novo")
                    .font(.largeTitle)
                Text("Cadastre um novo item para medir, pode ser uma parte do seu corpo, a altura dos seus filhos, o tamanho de alguma planta, quantidade de kilometros corridos...")
                    .font(.body)
                    .padding(.vertical)
            }
            
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
            
            Button(action: createNewMeasurment) {
                Text("Criar novo item")
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    NewMeasurement(measured: .init(name: "Corridas", unit: .km))
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
