//
//  NewMeasured.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 14/10/24.
//

import SwiftUI
import SwiftData
struct NewMeasured: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var newMeasuredName: String = ""
    @State private var newMeasuredUnit: Measured.Units = .mm

    func createNewMeasured() {
        modelContext.insert(Measured(name: newMeasuredName, unit: newMeasuredUnit))
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
                Text("O que voce quer medir?")
                    .font(.headline)
                TextField("Quadril", text: $newMeasuredName)
                    .textFieldStyle(.plain)
                    .padding()
                
                Text("Qual a unidade de medida?")
                    .font(.headline)
                
                Picker("Selecione a unidade de medida", selection: $newMeasuredUnit) {
                    ForEach(Measured.Units.allCases, id: \.id) { unit in
                            Text(unit.rawValue)
                        }
                    }
                .pickerStyle(.wheel)
            }
            
            Button(action: createNewMeasured) {
                Text("Criar novo item")
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding(.horizontal)
    }
}

// preview with data and modelContainer for NewMeasure
#Preview {
    NewMeasured()
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
