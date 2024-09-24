//
//  DataController.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-23.
//

import Foundation

class DataController {
    static let shared: DataController = DataController()

    var astronauts: [String : Astronaut]
    var missions: [Mission]
    var missionsResolved: [MissionResolved] = []

    init() {
        astronauts = Bundle.main.decode("astronauts.json")
        missions = Bundle.main.decode("missions.json")

        for mission in missions {
            let crewResolved = mission.crew.map { member in
                guard let astronaut = astronauts[member.name] else {
                    fatalError("Mission \(member.name)")
                }

                return MissionResolved.CrewMember(astronaut: astronaut, role: member.role)
            }

            let missionResovled = MissionResolved(id: mission.id, launchDate: mission.launchDate, description: mission.description, crew: crewResolved)
            missionsResolved.append(missionResovled)
        }
    }
}
