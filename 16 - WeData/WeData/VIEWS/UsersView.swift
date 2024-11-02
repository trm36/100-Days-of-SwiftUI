//
//  UsersView.swift
//  WeData
//
//  Created by Taylor on 2024-11-02.
//

import SwiftData
import SwiftUI

struct UsersView: View {

    @Query var users: [User]

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }

    init() {}

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]? = nil) {
        if let sortOrder = sortOrder {
            _users = Query(filter: #Predicate<User> { user in
                user.joinDate >= minimumJoinDate
            }, sort: sortOrder)
        } else {
            _users = Query(filter: #Predicate<User> { user in
                user.joinDate >= minimumJoinDate
            }, sort: \User.name)
        }
    }
}

#Preview {
    UsersView()
        .modelContainer(for: User.self)
}
