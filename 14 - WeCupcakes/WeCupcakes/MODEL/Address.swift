//
//  Address.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import Foundation

struct Address: Codable, Hashable {
    var name: String = ""
    var street: String = ""
    var city: String = ""
    var zip: String = ""

    var isValidAddress: Bool {
        let nameTrim = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let streetTrim = street.trimmingCharacters(in: .whitespacesAndNewlines)
        let cityTrim = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let zipTrim = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        return !(nameTrim.isEmpty || streetTrim.isEmpty || cityTrim.isEmpty || zipTrim.isEmpty)
    }
}
