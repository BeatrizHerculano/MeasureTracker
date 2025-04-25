//
//  NewMeasured.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 14/10/24.
//

import SwiftUI
import SwiftData
import SFSymbolsPicker



struct NewMeasured: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var newMeasuredName: String = ""
    @State private var newMeasuredUnit: Measured.Units = .mm
    @State private var icon = Icon.arrowUpCircle
    @State private var color = Color.blue
    @State private var iconColor = false
    
    func createNewMeasured() {
        let newMeasured = Measured(
                   name: newMeasuredName,
                   unit: newMeasuredUnit,
                   icon: icon.rawValue,
                   color: color,
                   iconColor: iconColor
               )
               modelContext.insert(newMeasured)
               
               do {
                   try modelContext.save()
               } catch {
                   print("Error saving context: \(error)")
               }
               
               dismiss()
        dismiss()
    }
    
    var body: some View {
        Form {
            Section(header: Text("O que voce quer medir?")) {
                GroupBox {
                    TextField("Colocar nome aqui...", text: $newMeasuredName)
                }
            }
            
            Section(header: Text("Qual a unidade de medida?")) {
                GroupBox {
                    Picker("Selecione a unidade de medida", selection: $newMeasuredUnit) {
                        ForEach(Measured.Units.allCases, id: \.id) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section(header: Text("Qual Icone voce quer?")){
                IconPicker(selection: $icon, color: $color, iconColor: $iconColor)
            }
            
            
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Adicionar") {
                    createNewMeasured()
                }
            }
        }
        .navigationTitle("Add Measured")
        
        
    }
    
}

// preview with data and modelContainer for NewMeasure
#Preview {
    NewMeasured()
        .modelContainer(for: [Measurement.self, Measured.self], inMemory: true)
}
