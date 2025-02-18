//
//  Person.swift
//  WeTag
//
//  Created by Taylor on 2025-02-16.
//

import Foundation

struct Person: Codable, Identifiable, Hashable, Comparable, Equatable {
    var name: String
    var meetingNote: String
    var image: Data
    var id: UUID

    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
}
