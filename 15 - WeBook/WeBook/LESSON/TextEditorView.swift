//
//  TextEditorView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-07.
//

import SwiftUI

struct TextEditorView: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
                .background(.red)
        }
    }
}

#Preview {
    TextEditorView()
}
