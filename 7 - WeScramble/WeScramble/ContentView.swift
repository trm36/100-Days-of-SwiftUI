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
    @State private var score: Int = 0

    @FocusState private var entryIsFocus

    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError = false

    var body: some View {
        NavigationStack {

//            Text("FOO")
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
                        .focused($entryIsFocus)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Text(word)
                            Spacer()
                            Image(systemName: "\(word.count).circle.fill")
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(word), \(word.count) letters")
                    }
                }
            }
            .navigationTitle("WeScramble")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New Game", action: startGame)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("Score: \(score)")
                }
            }
        }
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") {
                newWord = ""
                entryIsFocus = true
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
        usedWords = []
        newWord = ""
        score = 0
    }

    private func addNewWord() {
        let trimmedWord = newWord.lowercased().filter { !($0.isWhitespace) }
        guard trimmedWord.count != 0 else { return }

        guard isLongEnough(word: trimmedWord) else {
            wordError(title: "Word Too Short", message: "Words must be at least three letters.")
            return
        }

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

        guard !isBeginingOfRootWord(word: trimmedWord) else {
            wordError(title: "Start Of Word Not Possible", message: "You can't answer with the start of the root word.")
            return
        }

        withAnimation {
            score += trimmedWord.count + usedWords.count
            usedWords.insert(trimmedWord, at: 0)
        }

        newWord = ""
        entryIsFocus = true
    }

    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    // MARK: - WORD VALIDATION METHODS
    private func isLongEnough(word: String) -> Bool {
        return word.count >= 3
    }

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

    private func isBeginingOfRootWord(word: String) -> Bool {
        return rootWord.starts(with: word)
    }
}

#Preview {
    ContentView()
}
