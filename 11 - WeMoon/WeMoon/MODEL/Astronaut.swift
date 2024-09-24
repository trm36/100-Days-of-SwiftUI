//
//  Astronaut.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-22.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String

    var imageName: String {
        return id
    }
}
