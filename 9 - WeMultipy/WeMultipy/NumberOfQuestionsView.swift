//
//  NumberOfQuestionsView.swift
//  WeMultipy
//
//  Created by Taylor on 2024-08-11.
//


import SwiftUI

struct NumberOfQuestionsView: View {

    @Binding var selection: Int?

    var body: some View {

        let colors = [Color.yellow, Color.orange, Color.red]

        VStack(spacing: 50.0) {
            ZStack {
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)

                VStack {
                    Text("Select the number of questions")
                }
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
            }
            .frame(width: 300, height: 150)
            .clipShape(.rect(cornerRadius: 10))

            Grid(verticalSpacing: 50.0) {
                ForEach(0..<3) { row in
                    GridRow {
                        let questionOption = row * 5 + 10
                        AnimatedButton(color: colors[row], text: "\(questionOption)", dimension: 100.0) {
                            guard selection == nil else { return }
                            selection = questionOption
                        }
                    }
                }
            }
        }
        .frame(width: 350, height: 600)
    }
}

#Preview {
    NumberOfQuestionsView(selection: .constant(nil))
}

