//
//  RequestResult.swift
//  WeMap
//
//  Created by Taylor on 2025-02-13.
//

import Foundation

struct RequestResult: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [String : Page]
}

struct Page: Codable, Identifiable, Comparable {

    let pageID: Int
    let title: String
    let terms: [String : [String]]?
    
    /// The description provide about the page.
    var description: String {
        return terms?["description"]?.first ?? "No further information"
    }


    // MARK: - CODABLE
    enum CodingKeys: String, CodingKey {
        case pageID = "pageid"
        case title = "title"
        case terms = "terms"
    }

    // MARK: - IDENTIFIABLE
    var id: Int { pageID }

    // MARK: - COMPARABLE
    static func <(lhs: Page, rhs: Page) -> Bool {
        return lhs.title < rhs.title
    }
}
