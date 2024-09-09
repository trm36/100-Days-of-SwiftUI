//
//  FirstView.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import SwiftUI

struct FirstView: View {

    @State private var user = User()
    @State private var showingSheet = false

    var body: some View {
        VStack(spacing: 40.0) {
            Text("Your name is \(user.firstName) \(user.lastName).")
            VStack {
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
            }

            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: user.firstName)
            }
        }
        .padding()
    }
}

#Preview {
    FirstView()
}
