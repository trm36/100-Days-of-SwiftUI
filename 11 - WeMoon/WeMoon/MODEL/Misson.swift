//
//  Misson.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-22.
//

import Foundation

struct Mission: Codable, Identifiable {
    var id: Int
    var launchDate: Date?
    var description: String
    var crew: [CrewMember]

    struct CrewMember: Codable {
        var name: String
        var role: String
    }
}

struct MissionResolved: Identifiable, Hashable {
    var id: Int
    var launchDate: Date?
    var description: String
    var crew: [CrewMember]

    var launchDateString: String {
        return launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "DNL"
    }

    var displayName: String {
        return "Apollo \(id)"
    }

    var imageName: String {
        return "apollo\(id)"
    }

    // MARK: - EQUATABLE
    static func == (lhs: MissionResolved, rhs: MissionResolved) -> Bool {
        return lhs.id == rhs.id
    }

    struct CrewMember: Identifiable, Hashable {
        var id: String {
            return astronaut.id
        }
        var astronaut: Astronaut
        var role: String

        // MARK: - EQUATABLE
        static func == (lhs: CrewMember, rhs: CrewMember) -> Bool {
            return lhs.id == rhs.id
        }
    }
}
