//
//  Address.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import Foundation

struct Address: Codable {
    var name: String = "Taylor"
    var street: String = "123 Main St."
    var city: String = "Anytown"
    var zip: String = "00000"

    var isValidAddress: Bool {
        return !(name.isEmpty || street.isEmpty || city.isEmpty || zip.isEmpty)
    }
}
