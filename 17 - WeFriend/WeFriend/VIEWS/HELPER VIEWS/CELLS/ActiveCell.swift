//
//  ActiveCell.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-03.
//

import SwiftUI

struct ActiveCell: View {
    var isActive: Bool
    @State private var animationAmount = 1.0

    var body: some View {
        if isActive {
            HStack {
                ActiveIndicator()
                Text("ACTIVE")
            }
        } else {
            HStack {
                Text("Not Active")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            ActiveCell(isActive: true)
            ActiveCell(isActive: false)
        }
        .navigationTitle("Active Cell")
        .navigationBarTitleDisplayMode(.inline)
    }
}
