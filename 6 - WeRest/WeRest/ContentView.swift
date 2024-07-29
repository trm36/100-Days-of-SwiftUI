//
//  ContentView.swift
//  WeRest
//
//  Created by Taylor on 7/28/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = .eightAM

    var body: some View {
        Form {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4.0...15.0, step: 0.5)

            DatePicker("Wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)

            Text(wakeUp, format: .dateTime.hour().minute())
        }
    }
}

#Preview {
    ContentView()
}
