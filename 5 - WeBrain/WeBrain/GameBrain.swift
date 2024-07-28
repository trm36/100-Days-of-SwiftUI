//
//  GameBrain.swift
//  WeBrain
//
//  Created by Taylor on 7/28/24.
//

import Foundation

class GameBrain {
    private static let defaultTurnCount: UInt = 10
    private var turns: [Turn] = GameBrain.generateQuestionList()
    private(set) var score: Int = 0
    private(set) var currentTurn: Turn?


    static func generateQuestionList(count: UInt = GameBrain.defaultTurnCount) -> [Turn] {
        guard count > 0 else { return [] }

        var turns: [Turn] = []

        for _ in 0..<count {
            turns.append(Turn())
        }

        return turns
    }

    init() {
        nextTurn()
    }

    func nextTurn() {
        self.currentTurn = turns.popLast()
    }

    func checkAnswer(guess: Turn.Move) -> Bool {
        if guess == currentTurn?.correctResponse {
            // >< CORRECT
            score += 1
            return true
        } else {
            // >< INCORRECT
            score -= 1
            return false
        }
    }
}
