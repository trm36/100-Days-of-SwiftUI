//
//  ProspectsView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftData
import SwiftUI

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

    init(filter: FilterType) {
        self.filter = filter

        let sort = [SortDescriptor(\Prospect.name)]

        switch filter {
        case .none:
            // default value set in @Query property
            break
        case .contacted:
            _prospects = Query(filter: #Predicate { $0.isContacted }, sort: sort)
        case .uncontacted:
            _prospects = Query(filter: #Predicate { !$0.isContacted }, sort: sort)
        }
    }

    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("Scan", systemImage: "qrcode.viewfinder") {
                    let prospect = Prospect(name: "Paul Hudson", emailAddress: "paul@hackingwithswift.com", isContacted: false)
                    modelContext.insert(prospect)
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
