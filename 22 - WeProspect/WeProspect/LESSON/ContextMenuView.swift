//
//  ContextMenuView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftUI

struct ContextMenuView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill") {
                        backgroundColor = .red
                    }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContextMenuView()
}
