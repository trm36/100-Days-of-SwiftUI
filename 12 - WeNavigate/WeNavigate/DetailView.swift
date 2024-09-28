//
//  DetailView.swift
//  WeNavigate
//
//  Created by Taylor on 2024-09-25.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}

#Preview {
     NavigationStack {
        DetailView(number: 5, path: .constant(NavigationPath()))
    }
}
