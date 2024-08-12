//
//  ContentView.swift
//  WeMultipy
//
//  Created by Taylor on 2024-08-11.
//

import SwiftUI

struct ContentView: View {

    @State var timesTable: Int? = nil
    @State var numberOfQuestions: Int? = nil

    var body: some View {
        let set1 = timesTable != nil
        let set2 = numberOfQuestions != nil

        ZStack {
            TableQuestionView(selection: $timesTable.animation(.default.delay(0.8)))
                .offset(x: !set1 && !set2 ? 0.0 : -500.0)
            NumberOfQuestionsView(selection: $numberOfQuestions.animation(.default.delay(0.81)))
                .offset(x: set1 && !set2 ? 0.0 : (set1 && set2) ? -500.0 : 500.0)

            if let gameBrain = GameBrain(timesTable: timesTable, numberOfQuestions: numberOfQuestions) {
                QuestionsView(timesTable: $timesTable.animation(.default.delay(0.8)), numberOfQuestions: $numberOfQuestions, gameBrain: gameBrain)
                    .offset(x: set1 && set2 ? 0.0 : 500.0)
            } else {
                Color.red
                    .frame(width: 10.0, height: 10.0)
                    .offset(x: set1 && set2 ? 0.0 : 500.0)
            }

        }
    }
}

#Preview {
    ContentView()
}
