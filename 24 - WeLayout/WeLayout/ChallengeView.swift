//
//  ChallengeView.swift
//  WeLayout
//
//  Created by Taylor on 2025-03-26.
//

import SwiftUI

struct ChallengeView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let ratio = (proxy.frame(in: .global).maxY / fullView.frame(in: .global).height)

                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: ratio, saturation: 1.0, brightness: 1.0))
                            .scaleEffect(x: min((ratio / 2.0 + 0.5), 1))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(proxy.frame(in: .global).minY < 200 ? proxy.frame(in: .global).minY / 200.0 : 1)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ChallengeView()
}
