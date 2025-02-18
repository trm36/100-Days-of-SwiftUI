//
//  AddPersonView.swift
//  WeTag
//
//  Created by Taylor on 2025-02-17.
//

import PhotosUI
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Person) -> Void

    @State private var selectedItem: PhotosPickerItem?
    @State private var processedData: Data?
    @State private var processedImage: Image?

    @State private var name: String = ""
    @State private var meetingNote: String = ""

    @State private var missingInformationAlertIsPresented: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Color.clear
                        .aspectRatio(1.0, contentMode: .fill)
                        .overlay(
                            PhotosPicker(selection: $selectedItem) {
                                if let processedImage {
                                    processedImage
                                        .resizable()
                                        .scaledToFill()
                                        .padding(.vertical, -10.0)
                                        .padding(.horizontal, -15.0)
                                } else {
                                    ContentUnavailableView("Add Picture", systemImage: "photo.badge.plus")
                                }
                            }
                                .onChange(of: selectedItem, loadImage)
                        )
                }

                Section {
                    TextField(text: $name) {
                        Text("Name")
                    }
                    .font(.title2)
                    .bold()
                    TextField(text: $meetingNote) {
                        Text("Meeting Note")
                    }
                    .font(.subheadline)
                }
            }
            .navigationTitle("Add Person")
            .toolbar {
                Button("Save") {
                    if let data = processedData, !name.isEmpty, !meetingNote.isEmpty {
                        let newPerson = Person(name: name, meetingNote: meetingNote, image: data, id: UUID())
                        onSave(newPerson)
                        dismiss()
                    } else {
                        missingInformationAlertIsPresented = true
                    }
                }
                .alert("Missing Information", isPresented: $missingInformationAlertIsPresented, actions: {
                    Button("OK") {}
                }, message: {
                    Text("Please ensure you have a photo, name, and meeting note entered for this person.")
                })
            }
        }
    }

    private func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self),
                  let inputImage = UIImage(data: imageData) else { return }

            processedData = imageData
            processedImage = Image(uiImage: inputImage)
        }
    }
}

struct AddPersonView_Preview : PreviewProvider {
    static var previews: some View {
        return NavigationStack {
            AddPersonView { _ in }
        }
    }
}
