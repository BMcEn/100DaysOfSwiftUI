//
//  ContentView.swift
//  Challenge1
//
//  Created by Benjamin McEnulty on 2/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var startingValue = 0.0
    @State private var startingUnit: UnitLength = .meters
    @State private var endingUnit: UnitLength = .meters
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    var finalValue: Double {
        var initial = Measurement(value: Double(startingValue), unit: startingUnit)
        initial.convert(to: endingUnit)
        return initial.value
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Starting value",
                          value: $startingValue,
                          format: .number)
                
                Picker("Starting units", selection: $startingUnit) {
                    ForEach(units, id: \.self) {
                        Text($0.symbol)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                Picker("Ending units", selection: $endingUnit) {
                    ForEach(units, id: \.self) {
                        Text($0.symbol)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Converted to:")
            }
            
            Section {
                Text("\(String(format: "%.2f", startingValue)) \(startingUnit.symbol) is equal to \(String(format: "%.2f", finalValue)) \(endingUnit.symbol)")
            }
        }
        .keyboardType(.numberPad)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
