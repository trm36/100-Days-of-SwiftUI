//
//  ContentView.swift
//  WeSplit
//
//  Created by Taylor on 7/22/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @FocusState private var taxIsFocused: Bool

    @State private var checkAmount: Double = 10.0
    @State private var taxAmount: Double = 2.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20

    let tipPercentages = [10, 15, 20, 25, 0]

    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    private var tipAmount: Double {
        return checkAmount * Double(tipPercentage) / 100.0
    }

    private var totalAmount: Double {
        return checkAmount + taxAmount + tipAmount
    }

    private var perPersonAmount: Double {
        return totalAmount / Double(numberOfPeople)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Amount") {
                    HStack {
                        Text("Check Amount")
                            .accessibilityElement(children: .ignore)
                        TextField("Check Amount", value: $checkAmount, formatter: currencyFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($amountIsFocused)
                    }
                    .accessibilityElement(children: .combine)

                    HStack {
                        Text("Tax")
                            .accessibilityElement(children: .ignore)
                        TextField("Tax Amount", value: $taxAmount, formatter: currencyFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($taxIsFocused)
                    }
                    .accessibilityElement(children: .combine)
                }

                Section("Gratuity") {
                    Picker("Gratuity", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tipPercentage in
                            Text(tipPercentage, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Number of people") {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<51) {
                            Text("\($0) people")
                                .tag($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Totals") {
                    HStack {
                        Text("Check amount")
                        Spacer()
                        Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .accessibilityElement(children: .combine)

                    HStack {
                        Text("Tax amount")
                        Spacer()
                        Text(taxAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .accessibilityElement(children: .combine)


                    HStack {
                        Text("Gratuity")
                        Spacer()
                        Text(tipAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .accessibilityElement(children: .combine)

                    HStack {
                        Text("Total")
                            .bold()
                        Spacer()
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .bold()
                    }
                    .accessibilityElement(children: .combine)
                }

                Section("Split") {
                    HStack {
                        Text("Amount per person")
                            .bold()
                        Spacer()
                        Text(perPersonAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .bold()
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused || taxIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                        taxIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
