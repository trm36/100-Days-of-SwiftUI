//
//  TableQuestionView.swift
//  WeMultipy
//
//  Created by Taylor on 2024-08-10.
//

import SwiftUI

struct TableQuestionView: View {
    
    @Binding var selection: Int?
    
    var body: some View {

        let colors = [Color.green, Color.teal, Color.blue, Color.purple]

        VStack(spacing: 50.0) {
            ZStack {
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)

                VStack {
                    Text("Select the times table to practice")
                }
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
            }
            .frame(width: 300, height: 150)
            .clipShape(.rect(cornerRadius: 10))
            
            Grid(verticalSpacing: 50.0) {
                ForEach(0..<4) { row in
                    GridRow {
                        let lsr = (3 * row) + 2
                        /// Three (3) columns, except for the last row has two (2).
                        let rsr = row == 3 ? lsr + 2 : lsr + 3
                        ForEach(lsr..<rsr, id: \.self) { i in
                            Spacer()
                            AnimatedButton(color: colors[row], text: "\(i)", dimension: 75.0) {
                                guard selection == nil else { return }
                                selection = i
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .frame(width: 350, height: 600)
    }
}

#Preview {
    TableQuestionView(selection: .constant(nil))
}
