//
//  VHeaderView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-23.
//

import SwiftUI

struct VHeaderView<Content> : View where Content : View {
    var alignment: HorizontalAlignment = .center
    var header: String
    var content: () -> Content

    var body: some View {
        VStack(alignment: alignment, spacing: 3.0) {
            Text(header)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            content()
        }
    }
}

#Preview {
    VHeaderView(header: "TEST") {
        Text("This is the body.")
    }
}
