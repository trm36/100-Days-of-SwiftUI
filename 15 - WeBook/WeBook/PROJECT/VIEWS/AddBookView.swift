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
    @State private var rating: Int? = nil
    @State private var hasRead: Bool = false
    @State private var dateFinished: Date = .now

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
                
                Section("Read") {
                    Toggle("Finished Reading?", isOn: $hasRead)
                }

                if hasRead {
                    Section("Date Finished") {
                        DatePicker("Date Finished", selection: $dateFinished, in: Date.distantPast...Date.now, displayedComponents: [.date])
                    }

                    Section("Review") {
                        RatingView(label: "Rating", rating: $rating)
                        TextField("Review", text: $review, axis: .vertical)
                    }
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                Button("Save") {
                    let book: Book
                    if hasRead {
                        book = Book(title: title, author: author, genre: genre, dateFinished: dateFinished, rating: rating, review: review)
                    } else {
                        book = Book(title: title, author: author, genre: genre)
                    }

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
