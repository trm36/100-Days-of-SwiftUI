//
//  ListSelectView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftUI

struct ListSelectView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]

//    @State private var selection: String
    @State private var selection = Set<String>()

    var body: some View {

        EditButton()

        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }

//        if let selection {
//            Text("You selected \(selection)")
//        }

        if !selection.isEmpty {
            Text("You selected \(selection.formatted())")
        }
    }
}

#Preview {
    ListSelectView()
}
