//
//  FriendsList.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-04.
//

import SwiftData
import SwiftUI

struct FriendsList: View {

    let friends: [Friend]

    var body: some View {
        List {
            ForEach(friends) { friend in
                VDetailCell(leadingString: friend.name, trailingString: friend.id.uuidString, active: nil)
            }
        }
        .navigationTitle("Friends")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)

        let user = UserController.testUser()
        container.mainContext.insert(user)

        return NavigationStack {
            FriendsList(friends: user.friends)
                .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
