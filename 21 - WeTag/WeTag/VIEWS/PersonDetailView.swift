//
//  PersonDetailView.swift
//  WeTag
//
//  Created by Taylor on 2025-02-17.
//

import CoreLocation
import MapKit
import SwiftUI

struct PersonDetailView: View {

    var person: Person

    var body: some View {
        List {
            if let uiImage = UIImage(data: person.image) {
                Section {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(1.0, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                }
            }

            Section {
                Text(person.name)
                    .font(.title2)
                    .bold()
                Text(person.meetingNote)
                    .font(.subheadline)
            }

            if let location = person.location {
                Section {
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let coordinateRegion = MKCoordinateRegion(center: location, span: span)
                    let initialPosition = MapCameraPosition.region(coordinateRegion)
                    Map(initialPosition: initialPosition, interactionModes: [.zoom, .rotate, .pitch]) {
                        Marker(person.name, coordinate: location)
                    }

                    .aspectRatio(1.0, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                }
            }
        }
    }
}

struct PersonDetailView_Preview : PreviewProvider {
    static var previews: some View {
        return PersonDetailView(person: Person(name: "Name", meetingNote: "Meeting notes go here.", image: UIImage(named: "ales-krivec-15949")?.jpegData(compressionQuality: 0.8) ?? Data(), location: CLLocationCoordinate2D(latitude: 37.789467, longitude: -122.416772), id: UUID()))
//                return PersonDetailView(person: Person(name: "Name", meetingNote: "Meeting notes go here.", image: UIImage(named: "ales-krivec-15949-side")?.jpegData(compressionQuality: 0.8) ?? Data(), id: UUID()))
    }
}
