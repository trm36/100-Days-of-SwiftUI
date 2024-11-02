//
//  WeDataApp.swift
//  WeData
//
//  Created by Taylor on 2024-11-01.
//

import SwiftUI

@main
struct WeDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
