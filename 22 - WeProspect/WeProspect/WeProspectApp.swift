//
//  WeProspectApp.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftData
import SwiftUI

@main
struct WeProspectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
