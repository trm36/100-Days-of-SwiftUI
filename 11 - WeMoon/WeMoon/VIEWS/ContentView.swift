//
//  ContentView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-22.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            ScrollView {
                let columns = [
                    GridItem(.adaptive(minimum: 150.0)),
                ]

                LazyVGrid(columns: columns) {
                    let dataController = DataController.shared
                    ForEach(dataController.missionsResolved) { mission in
                        NavigationLink {
                            MissonDetailView(mission: mission)
                        } label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150.0, height: 150.0)
                                    .padding(.vertical)
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.launchDateString)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10.0))
                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(.lightBackground))
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Missions")
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
