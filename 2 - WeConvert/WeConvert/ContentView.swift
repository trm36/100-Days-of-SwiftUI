//
//  ContentView.swift
//  WeConvert
//
//  Created by Taylor on 7/23/24.
//

import SwiftUI

struct ContentView: View {

    @FocusState private var inputIsFocused: Bool

    @State private var inputValue: Double = 1.0
    @State private var inputUnit: WeConvertUnit = .feet
    @State private var outputUnit: WeConvertUnit = .meters

    private var result: String {
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit.unit)
        let conversion = inputMeasurement.converted(to: outputUnit.unit)

        let inputString =  "\(inputMeasurement.value.formatted(.number)) \(inputMeasurement.unit.symbol)"
        let outputString = "\(conversion.value.formatted(.number)) \(conversion.unit.symbol)"

        return "\(inputString) = \(outputString)"
    }

    private var formatter: MeasurementFormatter {
            let mf = MeasurementFormatter()
            mf.unitStyle = .short
            return mf
        }

    var body: some View {
        NavigationStack {
            Form {
                Section("Input Value") {
                    HStack {
                        Text("Input")
                            .accessibilityElement(children: .ignore)
                        TextField("Input Value", value: $inputValue, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($inputIsFocused)
                    }
                    .accessibilityElement(children: .combine)

                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(WeConvertUnit.allCases, id: \.self) { weConvertUnit in
                            Text(weConvertUnit.unit.symbol)
                                .accessibilityLabel(weConvertUnit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Output Unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(WeConvertUnit.allCases, id: \.self) { weConvertUnit in
                            Text(weConvertUnit.unit.symbol)
                                .accessibilityLabel(weConvertUnit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Result") {
                    Text(result)
                }
            }
            .navigationTitle("WeConvert")
        }
    }
}

#Preview {
    ContentView()
}
