//
//  Book.swift
//  WeBook
//
//  Created by Taylor on 2024-10-08.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Book {
    var title: String
    var author: String
    var genre: Genre
    var review: String?
    var rating: Int?
    var dateFinished: Date?

    var hasRead: Bool {
        return dateFinished != nil
    }

    var isValidBook: Bool {
        let titleTrim = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let authorTrim = author.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let reviewValid: Bool
        if let review = review {
            // if there is a reivew, it can't be empty
            let reviewTrim = review.trimmingCharacters(in: .whitespacesAndNewlines)
            reviewValid = reviewTrim.isEmpty
        } else {
            // it is valid to have no review, ie user hasn't finished book therefore can't review.
            reviewValid = true
        }
        
        let ratingValid: Bool
        if let rating = rating {
            // if there is a rating it must be 1, 2, 3, 4, or 5
            ratingValid = rating > 0 && rating < 6
        } else {
            // it is valid to have no rating, ie user hasn't finished book therefore can't rate.
            ratingValid = true
        }

        return !(titleTrim.isEmpty || authorTrim.isEmpty) && reviewValid && ratingValid
    }

    init(title: String, author: String, genre: Genre) {
        self.title = title
        self.author = author
        self.genre = genre
        self.dateFinished = nil
        self.rating = nil
        self.review = nil
    }

    init(title: String, author: String, genre: Genre, dateFinished: Date, rating: Int?, review: String) {
        self.title = title
        self.author = author
        self.genre = genre
        self.dateFinished = dateFinished
        self.rating = rating
        self.review = review
    }
    
    static func testBookFinished() -> Book {
        return Book(title: "Halloweentown", author: "Agatha Cromwell", genre: .fantasy, dateFinished: .now, rating: 4, review: "This is an awesome book that teach us to be who we are.")
    }

    static func testBookNotFinished() -> Book {
        return Book(title: "Halloweentown 2", author: "The Cromwell Family", genre: .fantasy)
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
        
        var image: Image {
            switch self {
            case .childrens:
                return Image("Childrens")
            case .fantasy:
                return Image("Fantasy")
            case .horror:
                return Image("Horror")
            case .mystery:
                return Image("Mystery")
            case .poetry:
                return Image("Poetry")
            case .romance:
                return Image("Romance")
            case .thriller:
                return Image("Thriller")
            }
        }
    }
}
