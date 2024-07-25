//
//  WeFlagApp.swift
//  WeFlag
//
//  Created by Taylor on 7/24/24.
//

import SwiftUI

@main
struct WeFlagApp: App {
    @State private var gameBrain = GameBrain()

    var body: some Scene {
        WindowGroup {
            if let question = gameBrain.nextQuestion() {
                QuestionView()
                    .environment(gameBrain)
            } else {
                Color.red // TODO: ** write error view.
                    .ignoresSafeArea()
            }
        }
    }
}
