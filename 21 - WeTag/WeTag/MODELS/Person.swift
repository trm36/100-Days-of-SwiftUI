//
//  Person.swift
//  WeTag
//
//  Created by Taylor on 2025-02-16.
//

import CoreLocation
import Foundation

struct Person: Codable, Identifiable, Hashable, Comparable, Equatable {
    var name: String
    var meetingNote: String
    var image: Data
    var location: CLLocationCoordinate2D?
    var id: UUID

    init(name: String, meetingNote: String, image: Data, location: CLLocationCoordinate2D? = nil, id: UUID = UUID()) {
        self.name = name
        self.meetingNote = meetingNote
        self.image = image
        self.location = location
        self.id = id
    }

    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }

    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
