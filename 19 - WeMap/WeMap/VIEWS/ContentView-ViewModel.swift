//
//  ContentView-ViewModel.swift
//  WeMap
//
//  Created by Taylor on 2025-02-13.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit
import SwiftUI

extension ContentView {
    
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var mapAppearance: MapAppearance = .standard
        var showingMissingAuthenticationErrorAlert: Bool = false
        var showingFailedAuthenticationErrorAlert: Bool = false

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        // MARK: - AUTHENTICATION
        var isUnlocked = false
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
                showingMissingAuthenticationErrorAlert = true
                return
            }

            let reason = "Please authenticate to unlock your places." // The string in our code is used for Touch ID, whereas the string in Info.plist is used for Face ID.
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                if success {
                    self.isUnlocked = true
                } else {
                    self.showingFailedAuthenticationErrorAlert = true
                }
            }
        }

        // MARK: - SAVE
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        // MARK: - CRUD
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(name: "New Location", description: "Add description", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }

        func updateLocation(location: Location) {
            guard let index = locations.firstIndex(of: location) else { return }
            locations[index] = location
            save()
        }

        // MARK: - MAP STYLE
        enum MapAppearance: String {
            case standard
            case hybrid

            var mapStyle: MapStyle {
                switch self {
                case .standard:
                    return .standard
                case .hybrid:
                    return .hybrid
                }
            }
        }

        func toggleMapAppearance() {
            switch mapAppearance {
            case .standard:
                mapAppearance = .hybrid
            case .hybrid:
                mapAppearance = .standard
            }
        }
    }
}
