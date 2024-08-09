//
//  TransitionView.swift
//  WeAnimate
//
//  Created by Taylor on 2024-08-09.
//

import SwiftUI

struct TransitionView: View {

    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
//                    .transition(.scale)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .transition(.pivot)
            }
        }
    }
}


#Preview {
    TransitionView()
}


struct CornerRotateModifier: ViewModifier {
    let degrees: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(degrees), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(degrees: -90.0, anchor: .topLeading),
                  identity: CornerRotateModifier(degrees: 0.0, anchor: .topLeading))
    }
}
