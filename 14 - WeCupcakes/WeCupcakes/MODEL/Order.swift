//
//  Order.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

@Observable
class Order {
    var cakeOption: Cupcake.CakeOption
    var quantity: Int
    var specialRequest: String
    var extraFrosting: Bool
    var addSprinkles: Bool

    init(cakeOption: Cupcake.CakeOption, quantity: Int, specialRequest: String? = nil, extraFrosting: Bool, addSprinkles: Bool) {
        self.cakeOption = cakeOption
        self.quantity = quantity
        self.specialRequest = specialRequest ?? ""
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
    }

    var total: Decimal {
        let cake = Decimal(quantity) * Cupcake.cakePrice
        let frosting = Decimal(quantity) * Cupcake.extraFrostingPrice
        let sprinkles = Decimal(quantity) * Cupcake.sprinklePrice

        var total = cake

        if extraFrosting {
            total += frosting
        }

        if addSprinkles {
            total += sprinkles
        }

        return total
    }
}
