//
//  ActiveIndicator.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-03.
//

import SwiftUI

struct ActiveIndicator: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Circle()
            .foregroundStyle(.green)
            .frame(width: 10.0)
            .overlay(
                Circle()
                    .stroke(.green, lineWidth: 1.0)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeInOut(duration: 2.5)
                        .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount = 2
            }
    }
}

#Preview {
    ActiveIndicator()
}
