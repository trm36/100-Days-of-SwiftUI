//
//  ContentView.swift
//  WeNavigate
//
//  Created by Taylor on 2024-09-25.
//

import SwiftUI

struct ContentView: View {
    @State private var pathStore = PathStore()
    @State private var title = "SwiftUI"

    var body: some View {

        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap Me") {
                        // button action here
                    }

                    Button("Tap Me 2") {
                        // button action here
                    }
                }
            }
//            .toolbar(.hidden, for: .navigationBar)
        }


//        NavigationStack(path: $pathStore.path) {
//            DetailView(number: 0, path: $pathStore.path)
//                .navigationDestination(for: Int.self) { i in
//                    DetailView(number: i, path: $pathStore.path)
//                }
//                .navigationTitle("Title goes here")
//                .navigationBarTitleDisplayMode(.inline)
//
//
//
//
//        }
    }
}

#Preview {
    ContentView()
}
