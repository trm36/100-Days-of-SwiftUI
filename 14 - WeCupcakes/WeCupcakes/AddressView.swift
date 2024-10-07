//
//  AddressView.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @State var selectedAddress: Address = Address()

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.deliveryAddress.name)
                TextField("Street", text: $order.deliveryAddress.street)
                TextField("City", text: $order.deliveryAddress.city)
                TextField("Zip", text: $order.deliveryAddress.zip)
            }

            let addresses = Array(AddressController.shared.addresses)
            if !addresses.isEmpty {
                Section {
                    Picker(selection: $selectedAddress) {
                        ForEach(addresses, id: \.self) { option in
                            Text(option.street)
                        }
                    } label: { }
                    .pickerStyle(.inline)
                    .onChange(of: selectedAddress) { old, new in
                        order.deliveryAddress = new
                        dismiss()
                    }
                } header: {
                    Text("Saved Addresses")
                } footer: {
                    Text("All addresses are saved on device.")
                }
            }
        }
        .navigationTitle("Delivery Details")
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order(cakeOption: .chocolate, quantity: 12, extraFrosting: false, addSprinkles: false))
    }
}
