//
//  SecondView.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import SwiftUI

struct SecondView: View {

    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 12.0) {
            Text("Second View for \(name)")

            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

#Preview {
    SecondView(name: "Thomas")
}
