//
//  CustomAccessibilityView.swift
//  WeFlash
//
//  Created by Taylor on 2025-03-13.
//

import SwiftUI

struct CustomAccessibilityView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State private var scale = 1.0

    var body: some View {
        // MARK: - accessibilityDifferentiateWithoutColor
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)

        // MARK: - accessibilityReduceMotion
//        Button("Hello, World!") {
//            if reduceMotion {
//                scale *= 1.5
//            } else {
//                withAnimation {
//                    scale *= 1.5
//                }
//            }
//        }
//        .scaleEffect(scale)

        Button("Hello, World!") {
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)

        // MARK: - accessibilityReduceTransparency
        Text("Hello, World!")
                    .padding()
                    .background(reduceTransparency ? .black : .black.opacity(0.5))
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
    }

    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

#Preview {
    CustomAccessibilityView()
}
