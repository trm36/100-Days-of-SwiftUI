//
//  QuestionsView.swift
//  WeMultipy
//
//  Created by Taylor on 2024-08-11.
//

import SwiftUI

struct QuestionsView: View {

    @Binding var timesTable: Int?
    @Binding var numberOfQuestions: Int?
    @State var gameBrain: GameBrain
    @State var showCorrectAnswerAlert: Bool = false
    @State var showIncorrectAnswerAlert: Bool = false
    @State var showEndOfGameAlert: Bool = false
    @State var enteredAnswer: Int? = nil
    @State var questionNumber: Int = 1
    @State var score: Int = 0
    @State var possibleScore: Int = 100

    @FocusState private var entryIsFocus

    var body: some View {
        VStack(spacing: 50.0) {
            let question = gameBrain.currentQuestion

            ZStack(alignment: .topLeading) {
                ZStack(alignment: .bottomTrailing) {
                    ZStack {
                        let colors = [Color.green, Color.teal, Color.blue, Color.purple]
                        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)

                        VStack {
                            Text("\(question.multiplicand) * \(question.multiplier) = ??")
                        }
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                    }

                    Text("SCORE: \(score)")
                        .font(.footnote)
                        .bold()
                        .padding(.trailing, 12)
                        .padding(.bottom, 4)
                        .foregroundStyle(.white)
                }

                Text("Q\(questionNumber)")
                    .font(.footnote)
                    .bold()
                    .padding(.leading, 12)
                    .padding(.top, 4)
                    .foregroundStyle(.white)
            }
            .frame(width: 300.0, height: 100.0)
            .clipShape(.rect(cornerRadius: 10.0))

            TextField("Product", value: $enteredAnswer, format: .number)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .frame(width: 300.0)
                .focused($entryIsFocus)
                .onSubmit {
                    guard let enteredAnswer = enteredAnswer else { return }
                    if enteredAnswer == question.product {
                        // >< CORRECT ANSWER
                        showCorrectAnswerAlert = true
                    } else {
                        // >< INCORRECT ANSWER
                        showIncorrectAnswerAlert = true
                    }
                }
                .alert("Correct", isPresented: $showCorrectAnswerAlert) {
                    Button("OK") {
                        score += possibleScore

                        guard let nextQuestion = gameBrain.questions.popLast() else {
                            // >< END OF GAME
                            showEndOfGameAlert = true
                            return
                        }

                        enteredAnswer = nil
                        entryIsFocus = true
                        possibleScore = 100
                        gameBrain.currentQuestion = nextQuestion
                        questionNumber += 1
                    }
                }
                .alert("Incorrect", isPresented: $showIncorrectAnswerAlert) {
                    Button("OK") {
                        entryIsFocus = true

                        if possibleScore > 25 {
                            possibleScore = possibleScore / 2
                        } else {
                            possibleScore = 0
                        }
                    }
                }
                .alert("Good Game", isPresented: $showEndOfGameAlert) {
                    Button("OK") {
                        timesTable = nil
                        numberOfQuestions = nil
                    }
                }
        }
        .padding()
    }
}

#Preview {
    QuestionsView(timesTable: .constant(5), numberOfQuestions: .constant(5), gameBrain: GameBrain.sampleGame)
}
