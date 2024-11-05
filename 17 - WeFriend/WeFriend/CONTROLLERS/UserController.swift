//
//  UserController.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-02.
//

import Foundation
import SwiftData

struct UserController {
    static func loadUsers() async -> [User]? {
        do {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { fatalError("Failed to generate url to download data.") }
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            if !users.isEmpty {
                UserDefaults.standard.setValue(true, forKey: DataStatus.loadedInitialData.rawValue)
            }
            return users
        } catch {
            print("Failed to load users.")
            return nil
        }
    }

    static func testUser() -> User {
        guard let idFriendA = UUID(uuidString: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6"),
              let idFriendB = UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0"),
              let idFriendC = UUID(uuidString: "be5918a3-8dc2-4f77-947c-7d02f69a58fe"),
              let idFriendD = UUID(uuidString: "f2f86852-8f2d-46d3-9de5-5bed1af9e4d6"),
              let idUser = UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954"),
              let registered = ISO8601DateFormatter().date(from: "2015-11-10T01:47:18-00:00") else {
            fatalError("Unable to create test User.")
        }

        let tags = [
            "cillum",
            "consequat",
            "deserunt",
            "nostrud",
            "eiusmod",
            "minim",
            "tempor"
        ]

        let friendA = Friend(id: idFriendA, name: "Jewel Sexton")
        let friendB = Friend(id: idFriendB, name: "Hawkins Patel")
        let friendC = Friend(id: idFriendC, name: "Berger Robertson")
        let friendD = Friend(id: idFriendD, name: "Hess Ford")

        let friends = [friendA, friendB, friendC, friendD]

        let user = User(id: idUser, isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: registered, tags: tags, friends: friends)

        return user
    }

    enum DataStatus: String {
        case loadedInitialData
    }
}
