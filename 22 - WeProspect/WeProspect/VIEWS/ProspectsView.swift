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
                .swipeActions(edge: .leading) {
                    if !prospect.isContacted {
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
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

    // MARK: - LOCAL NOTIFICATIONS
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            // PRODUCTION TRIGGER
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            // TESTING TRIGGER
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    } else {
                        print("Unknown Error Occurred - Request Notification Authorization")
                    }
                }
            }
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
