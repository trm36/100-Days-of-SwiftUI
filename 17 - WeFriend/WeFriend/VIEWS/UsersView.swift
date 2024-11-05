//
//  UserList.swift
//  WeFriend
//
//  Created by Taylor on 2024-11-02.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var modelContext

    @State private var downloadButtonDisabled: Bool = false

    @State private var showingActiveOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
    ]

    var body: some View {
        NavigationStack {
            UserList(activeOnly: showingActiveOnly, sortOrder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    Button("Download Data", systemImage: "arrowshape.down.circle") {
                        Task {
                            downloadButtonDisabled = true
                            let users = await UserController.loadUsers() ?? []
                            downloadButtonDisabled = UserDefaults.standard.bool(forKey: UserController.DataStatus.loadedInitialData.rawValue)
                            for user in users {
                                modelContext.insert(user)
                            }
                        }
                    }
                    .disabled(downloadButtonDisabled)

                    Button(showingActiveOnly ? "Show All" : "Show Active") {
                        showingActiveOnly.toggle()
                    }

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                ])
                            Text("Sort by Company")
                                .tag([
                                    SortDescriptor(\User.company),
                                    SortDescriptor(\User.name),
                                ])
                        }
                    }
                }
        }
        .onAppear {
            downloadButtonDisabled = UserDefaults.standard.bool(forKey: UserController.DataStatus.loadedInitialData.rawValue)
        }
    }
}

#Preview {
    UsersView()
}
