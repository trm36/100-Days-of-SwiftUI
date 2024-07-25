//
//  QuestionView.swift
//  WeFlag
//
//  Created by Taylor on 7/24/24.
//

import SwiftUI

struct QuestionView: View {

    // MARK: - ENVIRONMENT VARIABLES
    @Environment(GameBrain.self) var gameBrain

    @State private var currentQuestion: GameBrain.Question?
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    @State private var showingEndGame = false
    @State private var score: Int = 0

    var body: some View {

        if let currentQuestion = currentQuestion {
            GeometryReader { geometry in
                ZStack {
                    RadialGradient(stops: [
                        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                    ], center: .top, startRadius: 200, endRadius: 400)
                    .ignoresSafeArea()

                    VStack {
                        Spacer()

                        Text("Guess The Flag")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(.white)

                        Spacer()
                        Spacer()

                        Text("Score \(score)")
                            .font(.title2.bold())
                            .foregroundStyle(.white)

                        Spacer()

                        VStack(spacing: 15.0) {
                            VStack(spacing: 5.0) {
                                Text("Tap the flag of")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.secondary)
                                Text(currentQuestion.correctAnswer.displayString.uppercased())
                                    .font(.largeTitle.weight(.heavy))
                            }

                            ForEach(0..<3) { i in
                                Button {
                                    flagTapped(i)
                                } label: {
                                    currentQuestion.shuffledOptions[i].image
                                        .clipShape(.capsule)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                        .padding(20.0)
                        .frame(maxWidth: geometry.size.width - 40.0)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20.0))
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue") {
                                askQuestion()
                            }
                        } message: {
                            Text("Your score is \(score)")
                        }
                        .alert("🏁 Game Complete", isPresented: $showingEndGame) {
                            Button("Play Again") {
                                // TODO: - ADD PLAY AGAIN LOGIC
                            }
                        } message: {
                            Text("Your final score is \(score)")
                        }
                    }
                    .padding()
                }
            }
        } else {
            Color.red
                .ignoresSafeArea()
                .onAppear {
                    askQuestion()
                }
        }
    }

    private func flagTapped(_ number: Int) {
        guard let currentQuestion = currentQuestion else { return }
        let guess = currentQuestion.shuffledOptions[number]
        if guess == currentQuestion.correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    private func askQuestion() {
        guard let nextQuestion = gameBrain.nextQuestion() else {
            showingEndGame = true
            return
        }

        currentQuestion = nextQuestion
    }
}

#Preview {
    let gameBrain: GameBrain = GameBrain()
    if let question = gameBrain.nextQuestion() {
        return QuestionView()
            .environment(gameBrain)
    } else {
        return Color.red // TODO: ** write error view.
            .ignoresSafeArea()
    }
}
