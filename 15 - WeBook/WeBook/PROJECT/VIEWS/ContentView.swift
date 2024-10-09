//
//  ContentView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-08.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]

    @State private var showingAddBook: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRankView(rank: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("WeBook")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddBook = true
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self)
}
