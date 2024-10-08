//
//  Student.swift
//  WeBook
//
//  Created by Taylor on 2024-10-07.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var givenName: String
    var familyName: String
    var name: String {
        return givenName + " " + familyName
    }

    init(id: UUID, givenName: String, familyName: String) {
        self.id = id
        self.givenName = givenName
        self.familyName = familyName
    }
}
