//
//  MissonCell.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-28.
//

import SwiftUI

struct MissonCell: View {
    var mission: MissionResolved

    var body: some View {
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

#Preview {
    let mission = DataController.shared.missionsResolved[9]
    return MissonCell(mission: mission)

}
