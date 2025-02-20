//
//  PersonListView-ViewModel.swift
//  WeTag
//
//  Created by Taylor on 2025-02-18.
//

import Foundation

extension PersonListView {
    public class ViewModel: ObservableObject {

        @Published private(set) var persons: [Person]

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                persons = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                persons = []
            }
        }

        // MARK: - ADD PERSON
        func addPerson(_ person: Person) {
            persons.append(person)
            persons.sort()
            save()
        }


        // MARK: - SAVE
        private let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
        private func save() {
            do {
                let data = try JSONEncoder().encode(persons)
                try data.write(to: savePath, options: [.atomic])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}

