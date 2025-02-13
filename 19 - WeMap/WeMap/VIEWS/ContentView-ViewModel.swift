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

extension ContentView {
    
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?

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

            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                // >< no face/touch ID.
                return
            }

            let reason = "Please authenticate to unlock your places." // The string in our code is used for Touch ID, whereas the string in Info.plist is used for Face ID.
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    self.isUnlocked = true
                } else {
                    // >< error
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
    }
}
