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

    var launchDateString: String {
        return launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "DNL"
    }

    var displayName: String {
        return "Apollo \(id)"
    }

    var imageName: String {
        return "apollo\(id)"
    }


    struct CrewMember: Codable {
    //    var astronaut: Astronaut
        var name: String
        var role: String
    }
}
