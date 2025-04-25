//
//  MeasuredItem.swift
//  MeasureTracker
//
//  Created by Beatriz Herculano on 26/01/25.
//
import SwiftUI

struct MeasuredItem: View {
    
    var measured: Measured
    
    var body: some View {
        NavigationLink(value: measured){
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(hex: measured.color))
                    .overlay{
                        Image(systemName: measured.icon)
                            .resizable()
                            .padding(2)
                            .frame(width: 40, height: 40)
                            .foregroundColor(
                                measured.getIconColor()
                            )
                    }
                VStack (alignment: .leading){
                    Text(measured.name)
                        .font(.title2)
                    Text("\(measured.measures.count) mediç\(measured.measures.count == 1 ? "ão" : "ões")")
                }
            }
        }
    }
}

#Preview {
    MeasuredItem(measured: .init(name: "Corrida", unit: .km, icon: "star.fill", color: Color.blue, iconColor: true))
}
