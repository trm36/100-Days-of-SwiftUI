//
//  Untitled.swift
//  WeMap
//
//  Created by Taylor Mott on 11/28/24.
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable, Equatable {
    // MARK: - PROPERTIES
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    
    // MARK: - COMPUTED PROPERTIES
    var coordinate: CLLocationCoordinate2D {
       return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    // MARK: - SAMPLE DATA
#if DEBUG
    static let example = Location(name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
#endif
    
    
    // MARK: - INITIALIZERS
    init(id: UUID = UUID(), name: String, description: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from location: Location) {
        self.id = UUID()
        self.name = location.name
        self.description = location.description
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
    
    // MARK: - EQUATABLE
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}
