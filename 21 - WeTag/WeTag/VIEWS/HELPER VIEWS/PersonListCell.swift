//
//  PersonListCell.swift
//  WeTag
//
//  Created by Taylor on 2025-02-18.
//

import SwiftUI

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

#Preview {
    List {
        PersonListCell(person: Person(name: "Name", meetingNote: "Meeting notes go here.", image: UIImage(named: "ales-krivec-15949")?.jpegData(compressionQuality: 0.8) ?? Data(), id: UUID()))
    }
}
