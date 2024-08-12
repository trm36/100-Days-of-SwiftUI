//
//  AnimatedButton.swift
//  WeMultipy
//
//  Created by Taylor on 2024-08-11.
//

import SwiftUI

struct AnimatedButton: View {
    @State var isSelected: Bool = false
    let color: Color
    let text: String
    var dimension: CGFloat = 50.0
    let action: () -> Void
    var body: some View {

        Button {
            action()
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                isSelected = true
            }
        } label: {
            Text(text)
        }
        .foregroundStyle(.white)
        .frame(width: dimension, height: dimension)
        .background(color)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(isSelected ? 360.0 : 0.0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}
