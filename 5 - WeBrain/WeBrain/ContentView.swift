//
//  ContentView.swift
//  WeBrain
//
//  Created by Taylor on 7/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var gameBrain = GameBrain()
    @State private var showingAnswer = false
    @State private var scoreTitle: String = ""
    @State private var scoreMessage: String = ""

    var body: some View {
        guard let currentTurn = gameBrain.currentTurn else {
            return AnyView( VStack {
                Spacer()
                Text("FINAL SCORE")
                    .font(.title)
                Text("\(gameBrain.score)")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button("New Game") {
                    gameBrain = GameBrain()
                }
            })
        }

        let view = VStack(spacing: 2.0) {
            Spacer()
            Spacer()

            HStack {
                Text("WeBrain")
                Spacer()
                Text("Score: \(gameBrain.score)")
            }
            .padding()

            VStack {
                Text("\(currentTurn.move.symbol)")
                    .font(.system(size: 100.0))
                Text("\(currentTurn.move.rawValue)")
                    .font(.largeTitle)
                Text("\(currentTurn.prompt.rawValue)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.vertical, 6.0)
                    .padding(.horizontal, 16.0)
                    .background(currentTurn.prompt == .win ? .green : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }

            Spacer()
            Spacer()
            Spacer()

            HStack(spacing: 16.0) {
                let possibleAnswers = currentTurn.possibleAnswers.shuffled()


                ForEach(0..<2) { index in
                    let possibleAnswer = possibleAnswers[index]
                    Button {
                        let correct = gameBrain.checkAnswer(guess: possibleAnswer)
                        scoreTitle = correct ? "Correct" : "Wrong"
                        let promptedAction = currentTurn.prompt == .win ? "beat" : "lose to"
                        if correct {
                            scoreMessage = "\(possibleAnswer.symbol) does \(promptedAction) \(currentTurn.move.symbol)"
                        } else {
                            scoreMessage = "\(possibleAnswer.symbol) does not \(promptedAction) \(currentTurn.move.symbol)"
                        }
                        showingAnswer = true
                    } label: {
                        Text("\(possibleAnswer.symbol)")
                            .font(.system(size: 80.0))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1.0, contentMode: .fit)
                    .background(currentTurn.prompt == .win ? .green : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
            }
            .padding()

            Spacer()
        }
        .alert(scoreTitle, isPresented: $showingAnswer) {
            Button("Continue") {
                let hasNextTurn = gameBrain.nextTurn()
            }
        } message: {
            Text("\(scoreMessage)")
        }


        return AnyView(view)
    }
}

#Preview {
    ContentView()
}
