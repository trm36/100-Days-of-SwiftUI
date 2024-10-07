//
//  AddressView.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            TextField("Name", text: $order.deliveryAddress.name)
            TextField("Street", text: $order.deliveryAddress.street)
            TextField("City", text: $order.deliveryAddress.city)
            TextField("Zip", text: $order.deliveryAddress.zip)
        }
        .navigationTitle("Delivery Details")
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order(cakeOption: .chocolate, quantity: 12, extraFrosting: false, addSprinkles: false))
    }
}
