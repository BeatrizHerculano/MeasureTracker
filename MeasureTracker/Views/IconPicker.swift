//
//  IconPicker.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 26/01/25.
//
import SwiftUI

enum Icon: String, Identifiable, CaseIterable {
    var id: Icon { self }
    case house =  "house"
    case musicNote =  "music.note"
    case folder =  "folder"
    case person =  "person"
    case plus =  "plus"
    case xmark =  "xmark"
    case checkmark =  "checkmark"
    case ellipsis =  "ellipsis"
    case arrowUpCircle = "arrow.up.circle"
    
}

struct IconPicker: View {
    @Binding var selection: Icon
    @Binding var color: Color
    @Binding var iconColor: Bool
    
    var body: some View {
        VStack{
            ColorPicker(selection: $color, supportsOpacity: false) {
                Text("Cor de fundo")
            }
            
            Toggle(isOn: $iconColor) {
                Text("Cor do icone")
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 5) {
                ForEach(Icon.allCases){icon in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 40, height: 40)
                        .foregroundColor(color.opacity(
                            icon == selection ? 1 :0
                        ))
                        .overlay{
                            Image(systemName: icon.rawValue)
                                .resizable()
                                .padding(2)
                                .frame(width: 30, height: 30)
                                .foregroundColor(
                                    icon == selection
                                    ? (iconColor ? .white : .black) // Apenas o ícone selecionado muda de cor
                                    : .gray // Ícones não selecionados têm uma cor padrão
                                )
                        }
                        .onTapGesture { selected in
                            selection = icon
                        }
                }
                
                
            }
        }
        
        
    }
}

