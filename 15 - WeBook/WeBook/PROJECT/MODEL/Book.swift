//
//  Book.swift
//  WeBook
//
//  Created by Taylor on 2024-10-08.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: Genre
    var review: String
    var rating: Int

    var isValidBook: Bool {
        let titleTrim = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let authorTrim = author.trimmingCharacters(in: .whitespacesAndNewlines)
        let reviewTrim = review.trimmingCharacters(in: .whitespacesAndNewlines)
        return !(titleTrim.isEmpty || authorTrim.isEmpty || reviewTrim.isEmpty) && rating > 0 && rating < 6
    }

    init(title: String, author: String, genre: Genre, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }

    enum Genre: String, Identifiable, CaseIterable, Codable {
        case fantasy
        case horror
        case childrens
        case mystery
        case poetry
        case romance
        case thriller

        var id: Genre {
            return self
        }

        var displayString: String {
            switch self {
            case .childrens:
                return "Childrens"
            case .fantasy:
                return "Fantasy"
            case .horror:
                return "Horror"
            case .mystery:
                return "Mystery"
            case .poetry:
                return "Poetry"
            case .romance:
                return "Romance"
            case .thriller:
                return "Thriller"
            }
        }
    }
}
