//
//  Job.swift
//  WeData
//
//  Created by Taylor on 2024-11-02.
//

import SwiftData

@Model
class Job {
    var name: String
    var priority: Int
    var owner: User?

    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
