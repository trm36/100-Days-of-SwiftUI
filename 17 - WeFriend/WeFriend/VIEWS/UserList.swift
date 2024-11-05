//
//  UserList.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-02.
//

import SwiftData
import SwiftUI

struct UserList: View {
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                VDetailCell(leadingString: "\(user.name), \(user.age)", trailingString: user.company, active: user.isActive)
            }
        }
        .navigationDestination(for: User.self) { user in
            UserDetail(user: user)
        }
    }

    init(activeOnly: Bool = false, sortOrder: [SortDescriptor<User>] = [SortDescriptor(\User.name)]) {
        if activeOnly {
            _users = Query(filter: #Predicate<User> { $0.isActive }, sort: sortOrder)
        } else {
            _users = Query(sort: sortOrder)
        }
    }
}

#Preview {
    UserList()
        .modelContainer(for: User.self)
}
