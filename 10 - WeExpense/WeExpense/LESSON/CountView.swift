//
//  CountView.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import SwiftUI

struct CountView: View {
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "tapCount")
//
//    var body: some View {
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//            UserDefaults.standard.set(tapCount, forKey: "tapCount")
//        }
//    }

    @AppStorage("tapCount") private var tapCount: Int = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    CountView()
}
