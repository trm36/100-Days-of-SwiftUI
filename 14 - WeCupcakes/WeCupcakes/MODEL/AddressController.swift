//
//  AddressController.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import Foundation

class AddressController {
    static let shared = AddressController()

    private let kAddresses: String = "addresses"

    private(set) var addresses: Set<Address> = [] {
        didSet {
            guard let encodedData = try? JSONEncoder().encode(Array(addresses)) else { return }
            UserDefaults.standard.set(encodedData, forKey: kAddresses)
        }
    }

    init() {
        guard let savedData = UserDefaults.standard.data(forKey: kAddresses),
              let decodedAddresses = try? JSONDecoder().decode([Address].self, from: savedData) else {
            addresses = []
            return
        }

        addresses = Set(decodedAddresses)
    }

    func addAddress(_ address: Address) {
        addresses.insert(address)
    }

    func deleteAddress(_ address: Address) {
        addresses.remove(address)
    }
}
