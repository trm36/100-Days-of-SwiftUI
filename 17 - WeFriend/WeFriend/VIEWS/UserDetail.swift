//
//  UserDetail.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-03.
//

import SwiftData
import SwiftUI

struct UserDetail: View {

    @Environment(\.modelContext) var modelContext
//    @Environment(\.dismiss) var dismiss

    let user: User

    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium

        return List {
            Section {
                ActiveCell(isActive: user.isActive)
            }

            Section {
                NavigationLink(value: user.friends) {
                    Text("^[\(user.friends.count) friend](inflect: true)")
                }
            }

            Section("Details") {
                HDetailCell(leadingString: "Age", trailingString: "\(user.age)")
                HDetailCell(leadingString: "Company", trailingString: user.company)
                HDetailCell(leadingString: "Email", trailingString: user.email)
                HDetailCell(leadingString: "Address", trailingString: user.address)
            }

            Section("About") {
                Text(user.about)
            }

            Section("Date Registered") {
                Text(dateFormatter.string(from: user.registered))
            }

            Section("Tags") {
                TagCell(tags: user.tags)
            }
        }
        .navigationTitle(user.name)
        .navigationDestination(for: [Friend].self) { friends in
            FriendsList(friends: friends)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)

        let user = UserController.testUser()
        container.mainContext.insert(user)

        return NavigationStack {
            UserDetail(user: user)
                .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
