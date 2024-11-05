//
//  VDetailCell.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-04.
//

import SwiftUI

struct VDetailCell: View {
    let leadingString: String
    let trailingString: String
    let active: Bool?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(leadingString)
                Text(trailingString)
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            if active == true {
                Spacer()
                ActiveIndicator()
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            VDetailCell(leadingString: "Name", trailingString: "Taylor", active: nil)
        }
        .navigationTitle("Detail Cell")
        .navigationBarTitleDisplayMode(.inline)
    }
}
