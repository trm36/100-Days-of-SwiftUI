//
//  ContentView.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order(cakeOption: .chocolate, quantity: 12, extraFrosting: false, addSprinkles: false)

    @State private var selectedSpecialRequests: Bool = false

    var body: some View {

        NavigationStack {
            Form {
                Section("Cake Options") {
                    Picker("Cake Option", selection: $order.cakeOption) {
                        ForEach(Cupcake.CakeOption.allCases) { cakeOption in
                            Text(cakeOption.displayString)
                        }
                    }

                    Stepper(value: $order.quantity, in: 6...60, step: 6) {
                        VStack(alignment: .leading) {
                            Text("Quantity: \(order.quantity)")
                            Text("\(Cupcake.cakePrice.formatted(.currency(code: "USD"))) / cake")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Additions") {
                    Toggle(isOn: $order.extraFrosting) {
                        VStack(alignment: .leading) {
                            Text("Extra Frosting")
                            Text("+ \(Cupcake.extraFrostingPrice.formatted(.currency(code: "USD"))) / cake")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Toggle(isOn: $order.addSprinkles) {
                        VStack(alignment: .leading) {
                            Text("Add Sprinkles")
                            Text("+ \(Cupcake.sprinklePrice.formatted(.currency(code: "USD"))) / cake")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section() {
                    Toggle(isOn: $selectedSpecialRequests) {
                        Text("Special Requests")
                    }
                    .onChange(of: selectedSpecialRequests) { _, newValue in
                        // set special request to empty string when toggle turned off.
                        if !newValue { 
                            // >< toggle off
                            order.specialRequest = ""
                        }
                    }

                    if selectedSpecialRequests {
                        TextField("Requests", text: $order.specialRequest)
                    }
                }

                Section() {
                    NavigationLink(destination: AddressView(order: order)) {
                        HStack {
                            Text("Delivery Details")

                            Spacer()

                            if order.deliveryAddress.isValidAddress {
                                Text(order.deliveryAddress.street)
                                    .lineLimit(1)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                Section() {
                    HStack {
                        Text("TOTAL")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(order.total.formatted(.currency(code: "USD")))")
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section() {
                    NavigationLink("Checkout") {
                        CheckoutView(order: order)
                    }
                    .disabled(!order.deliveryAddress.isValidAddress)
                }

            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
