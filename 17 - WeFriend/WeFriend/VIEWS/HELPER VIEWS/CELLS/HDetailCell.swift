//
//  HDetailCell.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-04.
//

import SwiftUI

struct HDetailCell: View {
    let leadingString: String
    let trailingString: String

    var body: some View {
        HStack {
            Text(leadingString)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
            Spacer()
            Text(trailingString)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            HDetailCell(leadingString: "Name", trailingString: "Taylor")
        }
        .navigationTitle("Detail Cell")
        .navigationBarTitleDisplayMode(.inline)
    }
}
