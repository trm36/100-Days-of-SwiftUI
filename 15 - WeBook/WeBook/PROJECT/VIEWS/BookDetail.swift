//
//  BookDetail.swift
//  WeBook
//
//  Created by Taylor Mott on 10/23/24.
//

import SwiftData
import SwiftUI

struct BookDetail: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    book.genre.image
                        .resizable()
                        .scaledToFit()

                    Text(book.genre.rawValue.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                }
            }
            
            Text(book.author)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .padding()

            if book.hasRead {
                if let rating = book.rating {
                    RatingView(rating: .constant(rating))
                        .font(.largeTitle)
                        .padding(.bottom, 0.5)
                }

                if let dateFinished = book.dateFinished {
                    HStack {
                        Text("Date Finished")
                            .fontWeight(.medium)
                        Text("\(dateFinished.formatted(date: .long, time: .omitted))")
                    }
                    .font(.subheadline)
                    .padding(.bottom, 2.0)
                }

                if let review = book.review {
                    Text(review)
                        .padding(.bottom)
                } else {
                    Text("No review")
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                }
            } else {
                Text("IN PROGRESS")
                    .italic()
                    .foregroundStyle(.secondary)
            }
            
            Button {
                showingDeleteAlert = true
            } label: {
                Text("Delete Book")
                    .foregroundStyle(.red)
                    .bold()
            }
            .padding(2.0)
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
            .tint(.red)
        }
        .navigationTitle(book.title)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
    }
    
    private func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        
        return NavigationStack {
            BookDetail(book: Book.testBookFinished())
                .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
