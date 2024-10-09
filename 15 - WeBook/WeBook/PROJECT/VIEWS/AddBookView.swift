//
//  AddBookView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-08.
//

import SwiftUI

struct AddBookView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: Book.Genre = .fantasy
    @State private var review: String = ""
    @State private var rating: Int = -2

    // CONFIRMATION ALERT
    @State private var confirmMessage = ""
    @State private var showingConfirmAlert = false

    // ERROR ALERT
    @State private var errorMessage = ""
    @State private var showingErrorAlert = false

    var body: some View {
        NavigationStack{
            Form {
                Section("Title") {
                    TextField("Title", text: $title)
                }

                Section("Author") {
                    TextField("Author", text: $author)
                }

                Section("Genre") {
                    Picker("Genre", selection: $genre) {
                        ForEach(Book.Genre.allCases) {
                            Text($0.displayString)
                        }
                    }
                }

                Section("Rating") {
                    RatingView(label: "Rating", rating: $rating)
                }

                Section("Review") {
                    TextField("Review", text: $review, axis: .vertical)
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                Button("Save") {
                    let book = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                    if book.isValidBook {
                        modelContext.insert(book)
                        confirmMessage = "\(book.title) was added to your library."
                        showingConfirmAlert = true
                    } else {
                        errorMessage = "We were not able to add your book. Please check your entry; all fields are required."
                        showingErrorAlert = true
                    }
                }
            }
            .alert("Book Added", isPresented: $showingConfirmAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text(confirmMessage)
            }
            .alert("Error", isPresented: $showingErrorAlert) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
        AddBookView()
}
