//
//  ContentView.swift
//  WeLayout
//
//  Created by Taylor on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
//            .frame(width: 300, height: 300)
            .frame(width: 300, height: 300, alignment: .bottom)
//            .offset(x: 10.0, y: 10.0)
            .background(.red)

        HStack(alignment: .firstTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }

        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { d in d[.trailing] }
            Text("This is a longer line of text")
        }

        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in Double(position) * -10 }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
