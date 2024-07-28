//
//  Turn.swift
//  WeBrain
//
//  Created by Taylor on 7/28/24.
//

import Foundation

struct Turn {
    let move: Move
    let prompt: Prompt

    init() {
        self.move = Move.allCases.shuffled()[0]
        self.prompt = Prompt.allCases.shuffled()[0]
    }

    var correctResponse: Move {
        switch move {
        case .rock:
            switch prompt {
            case .win:
                return .paper // PAPER BEATS ROCK
            case .lose:
                return .scissors // SCISSORS LOSE TO ROCK
            }
        case .paper:
            switch prompt {
            case .win:
                return .scissors // SCISSORS BEATS PAPER
            case .lose:
                return .rock // ROCK LOSES TO PAPER
            }
        case .scissors:
            switch prompt {
            case .win:
                return .rock  // ROCK BEATS SCISSORS
            case .lose:
                return .paper // PAPER LOSES TO SCISSORS
            }
        }
    }

    var possibleAnswers: [Move] {
        return Move.allCases.filter { $0 != move }
    }

    enum Move: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"

        var symbol: String {
            switch self {
            case .rock:
                return "🪨"
            case .paper:
                return "📄"
            case .scissors:
                return "✂️"
            }
        }

        var hand: String {
            switch self {
            case .rock:
                return "👊"
            case .paper:
                return "🫳"
            case .scissors:
                return "✌️"
            }
        }
    }

    enum Prompt: String, CaseIterable {
        case win = "Win"
        case lose = "Lose"
    }
}


