//
//  ButtonAnimationsView.swift
//  WeAnimate
//
//  Created by Taylor on 2024-08-08.
//

import SwiftUI

struct ButtonAnimationsView: View {

    @State private var animationAmountRed = 1.0
    @State private var animationAmountBlue = 1.0
    @State private var animationAmountGreen = 1.0
    @State private var animationAmountOrange = 0.0
    @State private var animationAmountPurple = false

    @State private var enabled = false

    var body: some View {
        print("Red: \(animationAmountRed)")
        print("Blue: \(animationAmountBlue)")
        print("Green: \(animationAmountGreen)")

        return VStack {
            Spacer()

            Button("Tap Me") {
                animationAmountRed += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmountRed)
            .blur(radius: (animationAmountRed - 1) * 3)
            .animation(.easeInOut(duration: 2.0)
                            .delay(1.0)
                                .repeatCount(3, autoreverses: true),
                   value: animationAmountRed)

            Spacer()

            Button("No, Tap Me!") {

            }
            .padding(50)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(.blue)
                    .scaleEffect(animationAmountBlue)
                    .opacity(2 - animationAmountBlue)
                    .animation(
                        .easeOut(duration: 1.5)
                        .repeatForever(autoreverses: false),
                        value: animationAmountBlue
                    )
            )
            .onAppear {
                animationAmountBlue = 2.0
            }

            Spacer()

            VStack(spacing: 10.0) {
                Button("Tap Me") {
                    animationAmountGreen += 1
                }
                .padding(50)
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .scaleEffect(animationAmountGreen)

                Stepper("Scale Amount", value: $animationAmountGreen.animation(
                    .easeInOut(duration: 1.0)
                    .repeatCount(3, autoreverses: true)
                ), in: 1...10)
            }
            .padding(.horizontal)

            Spacer()

            Button("Tap Me") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmountOrange += 360.0
                }
            }
            .padding(50)
            .background(.orange)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(
                .degrees(animationAmountOrange),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )

            Spacer()

            Button("Tap Me") {
                enabled.toggle()
            }
            .padding(50)
            .background(enabled ? .purple : .pink)
            .foregroundStyle(.white)
            .animation(nil, value: enabled)
            .clipShape(.rect(cornerRadius: enabled ? 60 : 10))
            .animation(.spring(duration: 1.0, bounce: 0.6), value: enabled)

            Spacer()
        }
    }
}

#Preview {
    ButtonAnimationsView()
}
