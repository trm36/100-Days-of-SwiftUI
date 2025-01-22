//
//  EditAnnotationView.swift
//  WeMap
//
//  Created by Taylor Mott on 1/21/25.
//

import SwiftUI

struct EditAnnotationView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void

    @State private var name: String
    @State private var description: String
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Location Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = Location(from: location)
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    EditAnnotationView(location: .example, onSave: { _ in })
}
