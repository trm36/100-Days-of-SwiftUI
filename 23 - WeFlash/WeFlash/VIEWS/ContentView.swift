//
//  ContentView.swift
//  WeFlash
//
//  Created by Taylor on 2025-03-14.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = Array<Card>(repeating: .example, count: 10)

    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }

    private func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

#Preview {
    ContentView()
}
