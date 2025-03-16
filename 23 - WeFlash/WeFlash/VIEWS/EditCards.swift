//
//  EditCards.swift
//  WeFlash
//
//  Created by Taylor on 2025-03-15.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss

    @State var cards: [Card] = []
    @State var addPrompt: String = ""
    @State var addAnswer: String = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Add Prompt", text: $addPrompt)
                    TextField("Add Answer", text: $addAnswer)
                    Button("Add Card", action: addCard)
                }

                Section {
                    ForEach(cards) { card in
                        VStack {
                            Text(card.prompt)
                            Text(card.answer)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }

    private func addCard() {
        let trimmedPrompt = addPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = addAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }

        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }

    private func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }

    private func loadData() {
        guard let data = UserDefaults.standard.data(forKey: "Cards"),
              let decoded = try? JSONDecoder().decode([Card].self, from: data) else { return }
        cards = decoded
    }

    private func saveData() {
        guard let data = try? JSONEncoder().encode(cards) else { return }
        UserDefaults.standard.set(data, forKey: "Cards")
    }

    private func done() {
        dismiss()
    }
}

#Preview {
    EditCards(cards: Array<Card>(repeating: .example, count: 10))
}
