//
//  AddPersonView.swift
//  WeTag
//
//  Created by Taylor on 2025-02-17.
//

import MapKit
import PhotosUI
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Person) -> Void
    let locationFetcher = LocationFetcher()

    @State private var selectedItem: PhotosPickerItem?
    @State private var processedData: Data?
    @State private var processedImage: Image?

    @State private var name: String = ""
    @State private var meetingNote: String = ""
    @State private var location: CLLocationCoordinate2D?
    @State private var addLocationToggleIsOn: Bool = false

    @State private var missingInformationAlertIsPresented: Bool = false
    @State private var missingLocationAlertIsPresented: Bool = false

    var startPosition: MapCameraPosition {
        guard let location else {
            return MapCameraPosition.region(MKCoordinateRegion(center: .init(latitude: 37.789467, longitude: -122.416772), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
        }

        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        )
    }

    var body: some View {
        NavigationStack {
            List {
                // PHOTO
                Section {
                    Color.clear
                        .aspectRatio(1.0, contentMode: .fill)
                        .overlay(
                            PhotosPicker(selection: $selectedItem, matching: .images) {
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

                // TEXT
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

                // LOCATION
                Section {
                    HStack {
                        Toggle("Add Location?", isOn: $addLocationToggleIsOn)
                            .onChange(of: addLocationToggleIsOn, startLocationFetch)
                    }
                }

                if addLocationToggleIsOn {
                    Section {
                        if location != nil {
                            HStack {
                                ActiveIndicator()
                                Text("Location Set")
                            }
                        } else {
                            Text("No location set")
                                .foregroundStyle(.secondary)
                                .font(.callout)
                                .italic()
                        }

                        Button("Set Current Location") {
                            location = locationFetcher.lastKnownLocation
                        }
                    }
                }


                if let location {
                    Section {
                        Map(initialPosition: startPosition, interactionModes: [.zoom, .rotate, .pitch]) {
                            Marker(name, coordinate: location)
                        }
                        .aspectRatio(1.0, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                    }
                }
            }
            .navigationTitle("Add Person")
            .toolbar {
                Button("Save") {
                    if let data = processedData, !name.isEmpty, !meetingNote.isEmpty {
                        if addLocationToggleIsOn {
                            guard let location = location else {
                                missingLocationAlertIsPresented = true
                                return
                            }

                            saveWithLocation(name: name, meetingNote: meetingNote, imageData: data, location: location)
                        } else {
                            saveWithoutLocation(name: name, meetingNote: meetingNote, imageData: data)
                        }
                    } else {
                        missingInformationAlertIsPresented = true
                    }
                }
                .alert("Missing Information", isPresented: $missingInformationAlertIsPresented, actions: {
                    Button("OK") {}
                }, message: {
                    Text("Please ensure you have a photo, name, and meeting note entered for this person.")
                })
                .alert("No Location Set", isPresented: $missingLocationAlertIsPresented, actions: {

                    Button("Save Without Location", role: .destructive) {
                        guard let data = processedData else {
                            missingInformationAlertIsPresented = true
                            return
                        }
                        saveWithoutLocation(name: name, meetingNote: meetingNote, imageData: data)
                    }

                    Button("OK", role: .cancel) {}

                }, message: {
                    Text("You've indicated you'd like to save the location with this person, but have not set the location. Please save without location or set the location and try again.")
                })
            }
        }
    }

    private func saveWithLocation(name: String, meetingNote: String, imageData: Data, location: CLLocationCoordinate2D?) {
        let newPerson = Person(name: name, meetingNote: meetingNote, image: imageData, location: location)
        onSave(newPerson)
        dismiss()
    }

    private func saveWithoutLocation(name: String, meetingNote: String, imageData: Data) {
        let newPerson = Person(name: name, meetingNote: meetingNote, image: imageData)
        onSave(newPerson)
        dismiss()
    }

    private func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self),
                  let inputImage = UIImage(data: imageData) else { return }

            processedData = imageData
            processedImage = Image(uiImage: inputImage)
        }
    }

    private func startLocationFetch() {
        locationFetcher.start()
    }

    private func getCurrentLocation() {
        guard let location = locationFetcher.lastKnownLocation else { print("location not found"); return }
        print("your location is \(location)")
    }
}

struct AddPersonView_Preview : PreviewProvider {
    static var previews: some View {
        return NavigationStack {
            AddPersonView { _ in }
        }
    }
}
