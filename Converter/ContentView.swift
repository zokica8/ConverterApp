//
//  ContentView.swift
//  Converter
//
//  Created by Zoran Vasilic on 4/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber = 0.0
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    @FocusState private var focused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    // computed property
    var convertedNumber: Double {
        let number = inputNumber.isNaN ? 0 : inputNumber
        switch outputUnit {
        case "Celsius":
            if (inputUnit == "Fahrenheit") {
                return (number - 32) * 5/9
            }
            else if (inputUnit == "Kelvin") {
                return number - 273.15
            }
            else {
                return number
            }
        case "Fahrenheit":
            if (inputUnit == "Celsius") {
                return (number * 9/5) + 32
            }
            else if (inputUnit == "Kelvin") {
                return (number - 273.15) * 9/5 + 32
            }
            else {
                return number
            }
        case "Kelvin":
            if (inputUnit == "Celsius") {
                return number + 273.15
            }
            else if (inputUnit == "Fahrenheit") {
                return ((number - 32) / (9/5)) + 273.15
            }
            else {
                return number
            }
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    TextField("Enter number", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focused)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focused = false
                                }
                            }
                        }
                }
                Section("Select input unit") {
                    Picker("Select input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Select output unit") {
                    Picker("Select output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text("\(inputNumber, specifier: "%.0f") \(inputUnit) is \(convertedNumber, specifier: "%.2f") \(outputUnit)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
