//
//  CardView.swift
//  WeAnimate
//
//  Created by Taylor on 2024-08-08.
//

import SwiftUI

struct CardView: View {

    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        dragAmount = drag.translation
                    }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
//            .animation(.bouncy, value: dragAmount)
    }
}


#Preview {
    CardView()
}
