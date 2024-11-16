//
//  Friend.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-02.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    var id: UUID
    var name: String
    var owner: User?

    init(id: UUID, name: String, owner: User? = nil) {
        self.id = id
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
