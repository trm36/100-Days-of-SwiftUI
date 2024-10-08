//
//  SwiftDataView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-07.
//

import SwiftData
import SwiftUI

struct SwiftDataView: View {

    @Query var students: [Student]

    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement() ?? ""
                    let chosenLastName = lastNames.randomElement() ?? ""

                    let student = Student(id: UUID(), givenName: chosenFirstName, familyName: chosenLastName)
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    SwiftDataView()
        .modelContainer(for: Student.self)
}
