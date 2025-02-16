//
//  FlagButton.swift
//  WeFlag
//
//  Created by Taylor on 2024-08-10.
//

import SwiftUI

struct FlagButton: View {
    @State private var rotationAmount: Double = 0.0

    var country: GameBrain.Country
    var isCorrectAnswer: Bool
    var action: (() -> Void)?


    var body: some View {
        Button {
            action?()
            if isCorrectAnswer {
                withAnimation(.spring(duration: 1.0, bounce: 0.5)) {
                    rotationAmount += 360.0
                }
            }
        } label: {
            country.image
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
        .rotation3DEffect(
            .degrees(rotationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .accessibilityLabel(country.accessibilityDescription)
    }
}

#Preview {
    VStack(spacing: 24.0) {
        FlagButton(country: .us, isCorrectAnswer: true)
        FlagButton(country: .uk, isCorrectAnswer: false)
        FlagButton(country: .spain, isCorrectAnswer: false)
    }
}
