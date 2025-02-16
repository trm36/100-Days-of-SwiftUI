//
//  GameBrain.swift
//  WeFlag
//
//  Created by Taylor on 7/25/24.
//

import SwiftUI

@Observable
class GameBrain {

    private var questions: [Question] = Question.generateQuestionList()

    func nextQuestion() -> Question? {
        return questions.popLast()
    }

    func newGame() {
        questions = Question.generateQuestionList()
    }

    enum Country: String, CaseIterable {
        case estonia = "Estonia"
        case france = "France"
        case germany = "Germany"
        case ireland = "Ireland"
        case italy = "Italy"
        case nigeria = "Nigeria"
        case poland = "Poland"
        case spain = "Spain"
        case uk = "UK"
        case ukraine = "Ukraine"
        case us = "US"

        var displayString: String {
            switch self {
            case .uk:
                return "the UK"
            case .us:
                return "the US"
            case .estonia, .france, .germany, .ireland, .italy, .nigeria, .poland, .spain, .ukraine:
                return rawValue
            }
        }

        var accessibilityString: String {
            switch self {
            case .uk:
                return "the U K"
            case .us:
                return "the U S"
            case .estonia, .france, .germany, .ireland, .italy, .nigeria, .poland, .spain, .ukraine:
                return rawValue
            }
        }

        var accessibilityDescription: String {
            switch self {
            case .estonia: "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white."
            case .france: "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red."
            case .germany: "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold."
            case .ireland: "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange."
            case .italy: "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red."
            case .nigeria: "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green."
            case .poland: "Flag with two horizontal stripes. Top stripe white, bottom stripe red."
            case .spain: "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red."
            case .uk: "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background."
            case .ukraine: "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow."
            case .us: "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
            }
        }

        var image: Image {
            return Image(self.rawValue)
        }
    }

    struct Question {
        let correctAnswer: Country
        private let incorrectAnswerA: Country
        private let incorrectAnswerB: Country

        let shuffledOptions: [Country]

        private init(correctAnswer: Country, incorrectAnswerA: Country, incorrectAnswerB: Country) {
            self.correctAnswer = correctAnswer
            self.incorrectAnswerA = incorrectAnswerA
            self.incorrectAnswerB = incorrectAnswerB
            self.shuffledOptions = [correctAnswer, incorrectAnswerA, incorrectAnswerB].shuffled()
        }

        private typealias NewQuestionResponse = (question: Question, remainingCountries: [Country])
        private static func newQuestion(possibleCorrectAnswers: [Country]) -> NewQuestionResponse? {
            guard let correctAnswer = possibleCorrectAnswers.randomElement() else { return nil }
            let possibleIncorrectAnswers = Country.allCases.filter { $0 != correctAnswer }.shuffled()
            let incorrectAnswerA = possibleIncorrectAnswers[0]
            let incorrectAnswerB = possibleIncorrectAnswers[1]
            let question = Question(correctAnswer: correctAnswer, incorrectAnswerA: incorrectAnswerA, incorrectAnswerB: incorrectAnswerB)
            let remainingCorrectAnswers = possibleCorrectAnswers.filter { $0 != correctAnswer }

            return (question, remainingCorrectAnswers)
        }


        private static func generateQuestionList(remainingAnswers: [Country], questions: [Question] = []) -> [Question] {
            let response = Question.newQuestion(possibleCorrectAnswers: remainingAnswers)
            guard let responseUnwrapped = response else { return questions }
            var newQuestions = questions
            newQuestions.append(responseUnwrapped.question)
            return generateQuestionList(remainingAnswers: responseUnwrapped.remainingCountries, questions: newQuestions)
        }

        fileprivate static func generateQuestionList(allAnswers: [Country] = Country.allCases) -> [Question] {
            return generateQuestionList(remainingAnswers: allAnswers)
        }
    }
}
