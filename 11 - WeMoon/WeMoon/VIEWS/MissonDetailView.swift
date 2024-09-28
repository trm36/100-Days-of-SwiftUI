//
//  MissonDetailView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-23.
//

import SwiftUI

struct MissonDetailView: View {
    @State var mission: MissionResolved

    var body: some View {
        ScrollView {
            VStack(spacing: 12.0) {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { length, axis in
                        length * 0.5
                    }
                    .padding(.top)

                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.lightBackground)
                    .padding(.horizontal)
                    .padding(.top)

                HStack {
                    VHeaderView(alignment: .leading, header: "MISSION NAME") {
                        Text(mission.displayName)
                    }

                    Spacer()

                    VHeaderView(alignment: .trailing, header: "LAUNCH DATE") {
                        Text(mission.launchDateString)
                    }
                }
                .padding()

                VHeaderView(alignment: .leading, header: "CREW") {
                    HStack(spacing: 4.0) {
                        ForEach(mission.crew) { crewMember in
                            let astronaut = crewMember.astronaut
                            NavigationLink(value: astronaut) {
                                VStack {
                                    Image(astronaut.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.circle)
                                        .overlay(
                                            Circle()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                    Text(astronaut.name)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                    Text(crewMember.role)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                    Spacer()
                                }
                                .padding(.top)
                            }
                        }
                    }
                }
                .padding(.horizontal)


                VHeaderView(alignment: .leading, header: "DESCRIPTION") {
                    Text(mission.description)
                }
                .padding(.horizontal)
            }
        }
        .background(.darkBackground)
        .navigationTitle(mission.displayName)
        .navigationDestination(for: Astronaut.self) { astronaut in
            AstronautDetailView(astronaut: astronaut)
        }
    }
}

#Preview {
    let mission = DataController.shared.missionsResolved[9]
    return NavigationStack {
        MissonDetailView(mission: mission)
            .preferredColorScheme(.dark)
    }
}
