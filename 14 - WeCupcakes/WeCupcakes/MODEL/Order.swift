//
//  Order.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

@Observable
class Order: Codable {
    var cakeOption: Cupcake.CakeOption
    var quantity: Int
    var specialRequest: String
    var extraFrosting: Bool
    var addSprinkles: Bool
    var deliveryAddress: Address

    init(cakeOption: Cupcake.CakeOption, quantity: Int, specialRequest: String? = nil, extraFrosting: Bool, addSprinkles: Bool, deliveryAddress: Address = Address()) {
        self.cakeOption = cakeOption
        self.quantity = quantity
        self.specialRequest = specialRequest ?? ""
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
        self.deliveryAddress = deliveryAddress
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

    func reset() {
        cakeOption = .chocolate
        quantity = 6
        specialRequest = ""
        extraFrosting = false
        addSprinkles = false
        deliveryAddress = Address()
    }

    enum CodingKeys: String, CodingKey {
        case _cakeOption = "cakeOption"
        case _quantity = "quantity"
        case _specialRequest = "specialRequest"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _deliveryAddress = "deliveryAddress"
    }
}
