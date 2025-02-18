//
//  PersonDetailView.swift
//  WeTag
//
//  Created by Taylor on 2025-02-17.
//

import SwiftUI

struct PersonDetailView: View {

    var person: Person

    var body: some View {
        List {
            if let uiImage = UIImage(data: person.image) {
                Section {
                    Color.clear
                        .aspectRatio(1.0, contentMode: .fill)
                        .overlay(
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .padding(.vertical, -10.0)
                                .padding(.horizontal, -15.0)
                        )
                }
            }

            Section {
                Text(person.name)
                    .font(.title2)
                    .bold()
                Text(person.meetingNote)
                    .font(.subheadline)
            }
        }
    }
}

struct PersonDetailView_Preview : PreviewProvider {
    static var previews: some View {
        return PersonDetailView(person: Person(name: "Name", meetingNote: "Meeting notes go here.", image: UIImage(named: "ales-krivec-15949")?.jpegData(compressionQuality: 0.8) ?? Data(), id: UUID()))
        //        return PersonDetailView(person: Person(name: "Name", meetingNote: "Meeting notes go here.", image: UIImage(named: "ales-krivec-15949-side")?.jpegData(compressionQuality: 0.8) ?? Data(), id: UUID()))
    }
}
