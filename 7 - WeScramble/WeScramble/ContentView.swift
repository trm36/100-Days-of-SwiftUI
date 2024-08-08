//
//  ContentView.swift
//  WeScramble
//
//  Created by Taylor on 7/30/24.
//

import SwiftUI

struct ContentView: View {

    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""

    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(rootWord.localizedUppercase)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)

                }

                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit(addNewWord)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Text(word)
                            Spacer()
                            Image(systemName: "\(word.count).circle.fill")
                        }
                    }
                }
            }
        }
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") {
                newWord = ""
            }
        } message: {
            Text(errorMessage)
        }
    }

    private func startGame() {
        guard let file = Bundle.main.url(forResource: "WordList", withExtension: "txt") else { fatalError() }
        guard let allWords = try? String(contentsOf: file) else { fatalError() }
        let separatedWords = allWords.components(separatedBy: .newlines)
        rootWord = separatedWords.randomElement() ?? "SILKWORM"
    }

    private func addNewWord() {
        let trimmedWord = newWord.lowercased().filter { !($0.isWhitespace) }
        guard trimmedWord.count != 0 else { return }

        guard isOriginal(word: trimmedWord) else {
            wordError(title: "Word Used Already", message: "Be more original.")
            return
        }

        guard isReal(word: trimmedWord) else {
            wordError(title: "Word Not Recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isPossible(word: trimmedWord) else {
            wordError(title: "Word Not Possible", message: "You can't spell that word from '\(rootWord)'.")
            return
        }

        withAnimation {
            usedWords.insert(trimmedWord, at: 0)
        }

        newWord = ""
    }

    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    // MARK: - WORD VALIDATION METHODS
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            guard let position = tempWord.firstIndex(of: letter) else { return false }
            tempWord.remove(at: position)
        }

        return true
    }

    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
}

#Preview {
    ContentView()
}
