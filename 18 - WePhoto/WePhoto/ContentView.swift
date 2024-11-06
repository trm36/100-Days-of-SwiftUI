//
//  ContentView.swift
//  WePhoto
//
//  Created by Taylor on 2024-11-04.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack {
                Text("Hello, World!")
                    .blur(radius: blurAmount)

                Slider(value: $blurAmount, in: 0...20)
                    .onChange(of: blurAmount) { (oldValue, newValue) in
                        print("New value is \(newValue)")
                    }

                Button("Random Blur") {
                    blurAmount = Double.random(in: 0...20)
                }

                Button("Show Confirmation Dialog") {
                    showingConfirmation = true
                }
                .padding()
                .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                    Button("Red") { backgroundColor = .red }
                    Button("Green") { backgroundColor = .green }
                    Button("Blue") { backgroundColor = .blue }
                    Button("White") { backgroundColor = .white }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Select a new color")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
