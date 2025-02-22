//
//  ProspectsList.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-21.
//

import SwiftData
import SwiftUI

struct ProspectsList: View {
    @Environment(\.modelContext) var modelContext

    @Query var prospects: [Prospect]

    private let showsContactedIndicator: Bool

    var body: some View {
        List(prospects) { prospect in
            ZStack {
                ProspectCell(prospect: prospect, showsContactedIndicator: showsContactedIndicator)
                    .swipeActions(edge: .leading) {
                        if !prospect.isContacted {
                            Button("Remind Me", systemImage: "bell") {
                                addNotification(for: prospect)
                            }
                            .tint(.orange)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        if prospect.isContacted {
                            Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                                prospect.dateContacted = nil
                                prospect.dateUpdated = Date()
                            }
                            .tint(.blue)
                        } else {
                            Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                                let now = Date.now
                                prospect.dateContacted = now
                                prospect.dateUpdated = now
                            }
                            .tint(.green)
                        }

                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(prospect)
                        }
                    }

                // HIDDEN DISCLOSURE INDICATOR
                NavigationLink(destination: EditProspectView(prospect: prospect)) {
                    EmptyView()
                }.opacity(0.0)
            }
        }
    }


    // MARK: - INITIALIZERS
    init(prospectQuery: Query<Prospect, [Prospect]>, showsContactedIndicator: Bool) {
        _prospects = prospectQuery
        self.showsContactedIndicator = showsContactedIndicator
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
/*
            // TESTING TRIGGER
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
 */

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
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prospect.self, configurations: config)

    Prospect.addTestProspects(to: container.mainContext)
    let sortOrder = [SortDescriptor(\Prospect.name)]
    let query = Query(sort: sortOrder)
//    let query = Query(filter: #Predicate { $0.isContacted }, sort: sortOrder)
//    let query = Query(filter: #Predicate { !$0.isContacted }, sort: sortOrder)

    return NavigationStack {
        ProspectsList(prospectQuery: query, showsContactedIndicator: true)
    }
    .modelContainer(container)
}
