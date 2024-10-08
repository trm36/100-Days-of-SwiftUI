//
//  TextFieldView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-07.
//

import SwiftUI

struct TextFieldView: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        Form {
            TextField("Enter your text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
                .background(.red)
        }
    }
}

#Preview {
    TextFieldView()
}
