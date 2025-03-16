//
//  Card.swift
//  WeFlash
//
//  Created by Taylor on 2025-03-14.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var prompt: String
    var answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}
