//
//  WeBookApp.swift
//  WeBook
//
//  Created by Taylor on 2024-10-07.
//

import SwiftData
import SwiftUI

@main
struct WeBookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
//        .modelContainer(for: Student.self) - LESSON
    }
}
