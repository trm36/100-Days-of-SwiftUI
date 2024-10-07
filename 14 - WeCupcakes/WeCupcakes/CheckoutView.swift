//
//  CheckoutView.swift
//  WeCupcakes
//
//  Created by Taylor on 2024-10-06.
//

import SwiftUI

struct CheckoutView: View {

    // MARK: - STATE PROPERTIES
    @Bindable var order: Order


    // MARK: - ALERT PROPERTIES
    // ERROR MESSAGE
    @State private var showingErrorAlert: Bool = false
    @State private var errorMessageString: String = ""
    // CONFIRMATION MESSAGE
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false


    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3.0) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233.0)

                Text("Your total is \(order.total, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .alert("Error", isPresented: $showingErrorAlert) {
                    Button("OK") {
                        errorMessageString = ""
                    }
                } message: {
                    Text(errorMessageString)
                }
                .alert("Thank you!", isPresented: $showingConfirmation) {
                    Button("OK") { 
                        order.reset()
                        dismiss()
                    }
                } message: {
                    Text(confirmationMessage)
                }
            }
        }
        .navigationTitle("Checkout")
        .scrollBounceBehavior(.basedOnSize)
    }

    private func placeOrder() async {
        guard let encodedOrder = try? JSONEncoder().encode(order) else {
            errorMessageString = "Failed to encode order."
            showingErrorAlert = true
            return
        }

        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            errorMessageString = "Failed to create URL"
            showingErrorAlert = true
            return
        }

        AddressController.shared.addAddress(order.deliveryAddress)

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _ ) = try await URLSession.shared.upload(for: request, from: encodedOrder)

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.deliveryAddress.name) is on it's way."
            showingConfirmation = true
        } catch {
            errorMessageString = "Checkout failed: \(error.localizedDescription)"
            showingErrorAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order(cakeOption: .chocolate, quantity: 12, extraFrosting: false, addSprinkles: false))
    }
}
