//
//  SaveView.swift
//  WeExpense
//
//  Created by Taylor on 2024-09-08.
//

import SwiftUI

struct SaveView: View {

    @State private var user = User()

    private let kUserData = "userData"

    var body: some View {
        VStack(spacing: 40.0) {
            Text("Your name is \(user.firstName) \(user.lastName).")
            VStack {
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
            }

            Button("Save") {
                guard let data = try? JSONEncoder().encode(user) else { return }
                UserDefaults.standard.set(data, forKey: kUserData)
            }
        }
        .padding()
        .onAppear() {
            guard let data = UserDefaults.standard.data(forKey: kUserData),
             let user = try? JSONDecoder().decode(User.self, from: data) else {
                user = User()
                return
            }

            self.user = user
        }
    }
}

#Preview {
    SaveView()
}
