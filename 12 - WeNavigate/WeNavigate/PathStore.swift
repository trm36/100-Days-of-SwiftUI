//
//  PathStore.swift
//  WeNavigate
//
//  Created by Taylor on 2024-09-28.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        guard let data = try? Data(contentsOf: savePath), let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) else {
            path = NavigationPath()
            return
        }

        path = NavigationPath(decoded)
    }

    func save() {
        guard let representation = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}
