//
//  ContentView.swift
//  WeModify
//
//  Created by Taylor on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    let motto1 = Text("Draco dormiens")
        .font(.title)
    let motto2 = Text("nunquam titillandus")

    @State private var tipPercentage: Int = 20

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        Form {
            Section {
                motto1
                motto2
                motto1
                    .font(.callout)
            }

            Section {
                Picker("Gratuity", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) { tipPercentage in
                        Text(tipPercentage, format: .percent)
                    }
                }
                .pickerStyle(.segmented)

                Text("You selected \(tipPercentage.formatted(.percent))")
                    .foregroundStyle(tipPercentage == 0 ? .red : .primary)
            }

            Section {
                FlagImage(image: Image("US"))
            }

            Section {
                Text("WeModify")
                    .blueTitleStyle()
            }
        }
    }
}

#Preview {
    ContentView()
}
