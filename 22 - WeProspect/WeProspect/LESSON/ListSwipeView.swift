//
//  ListSwipeView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftUI

struct ListSwipeView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deleting")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    ListSwipeView()
}
