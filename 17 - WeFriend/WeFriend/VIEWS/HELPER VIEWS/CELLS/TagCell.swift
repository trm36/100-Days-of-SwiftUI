//
//  TagCell.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-04.
//

import SwiftUI

struct TagCell: View {

    let tags: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .padding(.horizontal)
                        .padding(.vertical, 12.0)
                        .background(.black)
                        .foregroundStyle(.white)
                        .bold()
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous))
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 4.0)
        .padding(.horizontal, -15.0)
        .padding(.bottom, -8.0)
        .contentMargins(.bottom, 12.0, for: .scrollContent)
        .contentMargins(.leading, 15.0, for: .scrollIndicators)
        .contentMargins(.trailing, 15.0, for: .scrollIndicators)
    }
}

#Preview {
    let tags = [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
    ]

    return NavigationStack {
        List {
            TagCell(tags: tags)
        }
        .navigationTitle("Tag Cell")
        .navigationBarTitleDisplayMode(.inline)
    }
}
