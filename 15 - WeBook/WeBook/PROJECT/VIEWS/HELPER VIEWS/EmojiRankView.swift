//
//  EmojiRankView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-09.
//

import SwiftUI

struct EmojiRankView: View {
    let rank: Int?

    var body: some View {
        switch rank {
        case nil:
            Text("⏳")
        case 1:
            Text("🤮")
        case 2:
            Text("👎")
        case 3:
            Text("✅")
        case 4:
            Text("⭐️")
        default:
            Text("🌠")
        }
    }
}

#Preview {
    EmojiRankView(rank: 5)
}
