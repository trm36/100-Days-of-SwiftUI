//
//  Cupcake.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import Foundation

struct Cupcake {
    static let cakePrice: Decimal = 3.25
    static let extraFrostingPrice: Decimal = 1.25
    static let sprinklePrice: Decimal = 0.25

    enum CakeOption: String, CaseIterable, Identifiable, Codable {
        case chocolate
        case vanilla
        case strawberry
        case rainbow

        var id: CakeOption {
            return self
        }

        var displayString: String {
            switch self {
            case .chocolate:
                return "Chocolate"
            case .vanilla:
                return "Vanilla"
            case .rainbow:
                return "Rainbow"
            case .strawberry:
                return "Strawberry"
            }
        }
    }
}
