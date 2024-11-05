//
//  User.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-02.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isActive = "isActive"
        case name = "name"
        case age = "age"
        case company = "company"
        case email = "email"
        case address = "address"
        case about = "about"
        case registered = "registered"
        case tags = "tags"
        case friends = "friends"
    }

    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    @Relationship(deleteRule: .cascade, inverse: \Friend.owner) var friends: [Friend] = []

    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend] = []) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        let registeredString = try container.decode(String.self, forKey: .registered)
        let dateFormatter = ISO8601DateFormatter()
        guard let registeredDate = dateFormatter.date(from: registeredString) else {
            throw DecodingError.dataCorruptedError(forKey: .registered, in: container, debugDescription: "Cannot decode registered date string \(registeredString)")
        }
        registered = registeredDate
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friend].self, forKey: .friends)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        let dateFormatter = ISO8601DateFormatter()
        let registeredString = dateFormatter.string(from: registered)
        try container.encode(registeredString, forKey: .registered)
        try container.encode(tags, forKey: .tags)
    }
}
