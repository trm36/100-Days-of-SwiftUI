//
//  ContentView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-22.
//

import SwiftUI

struct ContentView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                let columns = [
                    GridItem(.adaptive(minimum: 150.0)),
                ]

                LazyVGrid(columns: columns) {
                    let dataController = DataController.shared
                    ForEach(dataController.missionsResolved, id: \.self) { mission in
                        NavigationLink(value: mission) {
                            MissonCell(mission: mission)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Missions")
                .navigationDestination(for: MissionResolved.self) { mission in
                    MissonDetailView(mission: mission)
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
