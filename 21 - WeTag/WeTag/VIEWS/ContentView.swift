//
//  ContentView.swift
//  WeTag
//
//  Created by Taylor on 2025-02-16.
//

import PhotosUI
import SwiftUI


struct ContentView: View {

    @State private var people: [Person]
    @State private var showingAddPersonView: Bool = false
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            people = []
        }
    }

    var body: some View {
        NavigationStack {
            List(people) { person in
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
                        people.append(person)
                        people.sort()
                        save()
                    }
                }
            }
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }

}

#Preview {
    ContentView()
}

struct PersonListCell: View {
    var person: Person

    var body: some View {
        HStack {
            if let uiImage = UIImage(data: person.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fill)
                    .frame(width: 60.0)
                    .padding(.leading, -20.0)
                    .padding(.vertical, -10.0)
                    .padding(.trailing, 10.0)
            }

            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                Text(person.meetingNote)
                    .font(.caption)
            }
        }
    }
}
