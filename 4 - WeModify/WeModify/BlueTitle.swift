//
//  BlueTitle.swift
//  WeModify
//
//  Created by Taylor on 7/28/24.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .padding()
    }
}

extension View {
    func blueTitleStyle() -> some View {
        modifier(BlueTitle())
    }
}
