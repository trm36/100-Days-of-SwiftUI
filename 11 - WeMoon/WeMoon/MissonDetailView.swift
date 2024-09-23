//
//  MissonDetailView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-23.
//

import SwiftUI

struct MissonDetailView: View {
    @State var mission: Mission

    var body: some View {
        NavigationStack {
            VStack(spacing: 12.0) {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { length, axis in
                        length * 0.5
                    }

                VStack(spacing: 2.0) {
                    Text("LAUNCH DATE")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(mission.launchDateString)
                }
            }
            .navigationTitle(mission.displayName)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return MissonDetailView(mission: missions.first!)
}
