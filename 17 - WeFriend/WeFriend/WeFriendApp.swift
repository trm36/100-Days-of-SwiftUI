//
//  WeFriendApp.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-02.
//

import SwiftUI

@main
struct WeFriendApp: App {
    var body: some Scene {
        WindowGroup {
            UsersView()
        }
        .modelContainer(for: User.self)
    }
}
