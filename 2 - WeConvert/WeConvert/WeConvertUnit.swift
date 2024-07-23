//
//  WeConvertUnit.swift
//  WeConvert
//
//  Created by Taylor on 7/23/24.
//

import Foundation

enum WeConvertUnit: String, CaseIterable {
    case feet
    case yards
    case meters
    case kilometers
    case miles

    var unit: UnitLength {
        switch self {
        case .feet: return .feet
        case .yards: return .yards
        case .meters: return .meters
        case .kilometers: return .kilometers
        case .miles: return .miles
        }
    }
}
