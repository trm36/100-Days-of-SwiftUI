//
//  ProspectsView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import CodeScanner
import SwiftData
import SwiftUI

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext

    @State private var selectedProspects = Set<Prospect>()
    @State private var isShowingScanner = false

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


    // MARK: - INITIALIZERS
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

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(prospects, selection: $selectedProspects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                .tag(prospect)
                .swipeActions {
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)

                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(prospect)
                        }
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)

                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(prospect)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                    .sheet(isPresented: $isShowingScanner) {
                        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                    }
                }

                if !selectedProspects.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
        }
    }

    // MARK: - QR SCAN
    private func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    // MARK: - MULTI DELETE
    private func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    // MARK: - FILTER TYPE
    enum FilterType {
        case none, contacted, uncontacted
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
