//
//  GameBrain.swift
//  WeMultipy
//
//  Created by Taylor on 2024-08-11.
//

import Foundation

class GameBrain {
    let timesTable: Int
    let numberOfQuestions: Int
    var questions: [Question]
    var currentQuestion: Question

    init?(timesTable: Int?, numberOfQuestions: Int?) {
        guard let timesTableUnwrapped = timesTable, let numberOfQuestionsUnwrapped = numberOfQuestions else { return nil }
        self.timesTable = timesTableUnwrapped
        self.numberOfQuestions = numberOfQuestionsUnwrapped
        self.questions = GameBrain.generateQuestions(timesTable: timesTableUnwrapped, numberOfQuestions: numberOfQuestionsUnwrapped)
        guard let question = questions.popLast() else { return nil }
        currentQuestion = question
    }

    private static func generateQuestions(timesTable: Int, numberOfQuestions: Int) -> [Question] {
        var questions: [Question] = []
        for _ in 0..<numberOfQuestions {
            let newQuestion = Question(multiplier: timesTable)
            questions.append(newQuestion)
        }

        return questions
    }

    static let sampleGame: GameBrain = GameBrain(timesTable: 5, numberOfQuestions: 5)!
}

struct Question {
    let multiplier: Int
    let multiplicand: Int
    let product: Int

    init(multiplier: Int) {
        let seed = [0, 1].randomElement()

        if seed == 0 {
            self.multiplier = multiplier
            self.multiplicand = Int.random(in: 2...12)
        } else {
            self.multiplier = Int.random(in: 2...12)
            self.multiplicand = multiplier
        }

        self.product = self.multiplicand * self.multiplier
        print("\(self.multiplier) * \(self.multiplicand) = \(self.product)")
    }
}

