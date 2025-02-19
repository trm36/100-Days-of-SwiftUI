//
//  PersonListView.swift
//  WeTag
//
//  Created by Taylor on 2025-02-16.
//

import PhotosUI
import SwiftUI


struct PersonListView: View {

    @StateObject private var viewModel = ViewModel()
    @State private var showingAddPersonView: Bool = false

    var body: some View {
        NavigationStack {
            List(viewModel.persons) { person in
                NavigationLink(value: person) {
                    PersonListCell(person: person)
                }
            }
            .navigationTitle("WeTag")
            .navigationDestination(for: Person.self) { person in
                PersonDetailView(person: person)
            }
            .toolbar {
                Button("Add Person", systemImage: "plus") {
                    showingAddPersonView = true
                }
                .sheet(isPresented: $showingAddPersonView) {
                    AddPersonView { person in
                        viewModel.addPerson(person)
                    }
                }
            }
        }
    }
}

#Preview {
    PersonListView()
}
