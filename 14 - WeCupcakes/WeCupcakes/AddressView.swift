//
//  AddressView.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

struct AddressView: View {
    var order: Order

    var body: some View {
        Text(order.cakeOption.displayString)
            .navigationTitle("Address View")
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order(cakeOption: .chocolate, quantity: 12, extraFrosting: false, addSprinkles: false))
    }
}
