//
//  ProspectsView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @Environment(\.modelContext) var modelContext

    let filter: FilterType

    @State private var isShowingScanner = false
    @State private var query: Query<Prospect, [Prospect]>
    @State private var sortOrder: [SortDescriptor<Prospect>]

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


    // MARK: - INITIALIZERS
    init(filter: FilterType) {
        self.filter = filter

        let sortOrder = [SortDescriptor(\Prospect.name)]
        self.sortOrder = sortOrder

        switch filter {
        case .none:
            self.query = Query(sort: sortOrder)
        case .contacted:
            self.query = Query(filter: #Predicate { $0.dateContacted != nil }, sort: sortOrder)
        case .uncontacted:
            self.query = Query(filter: #Predicate { $0.dateContacted == nil }, sort: sortOrder)
        }
    }

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ProspectsList(prospectQuery: query, showsContactedIndicator: filter == .none)
                .navigationTitle(title)
                .toolbar {
/*
                    // ADDS DATA FOR EASY TESTING
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Download Data", systemImage: "arrowshape.down.circle") {
                            Prospect.addTestProspects(to: modelContext)
                        }
                    }
*/

                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([
                                        SortDescriptor(\Prospect.name),
                                    ])
                                Text("Sort by Email")
                                    .tag([
                                        SortDescriptor(\Prospect.emailAddress),
                                    ])
                                Text("Sort By Date Added")
                                    .tag([
                                        SortDescriptor(\Prospect.dateAdded, order: .reverse),
                                    ])
                                Text("Sort By Date Contacted")
                                    .tag([
                                        SortDescriptor(\Prospect.dateContacted, order: .reverse),
                                    ])
                            }
                            .onChange(of: sortOrder, updateQuery)
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                        .sheet(isPresented: $isShowingScanner) {
                            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                        }
                    }
                }
        }
    }

    // MARK: - QUERY
    private func updateQuery() {
        switch filter {
        case .none:
            query = Query(sort: sortOrder)
        case .contacted:
            query = Query(filter: #Predicate { $0.dateContacted != nil }, sort: sortOrder)
        case .uncontacted:
            query = Query(filter: #Predicate { $0.dateContacted == nil }, sort: sortOrder)
        }
    }

    // MARK: - QR SCAN - ADD PROSPECT
    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let now = Date.now

            let person = Prospect(name: details[0], emailAddress: details[1], dateAdded: now, dateUpdated: now)

            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    // MARK: - FILTER TYPE
    enum FilterType {
        case none, contacted, uncontacted
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prospect.self, configurations: config)

    Prospect.addTestProspects(to: container.mainContext)

    return ProspectsView(filter: .none)
        .modelContainer(container)
}
