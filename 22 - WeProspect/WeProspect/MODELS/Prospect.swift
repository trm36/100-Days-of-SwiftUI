//
//  Prospect.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var dateAdded: Date
    var dateUpdated: Date
    var dateContacted: Date?

    var isContacted: Bool {
        return dateContacted != nil
    }

    init(name: String, emailAddress: String, dateAdded: Date = Date(), dateUpdated: Date = Date(), dateContacted: Date? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.dateAdded = dateAdded
        self.dateUpdated = dateUpdated
        self.dateContacted = dateContacted
    }

    static func addTestProspects(to modelContext: ModelContext) {
        let now = Date()
        let twoHoursAgo = now.addingTimeInterval(-120 * 60)

        let prospect = Prospect(name: "Jon Prospect", emailAddress: "prospectjon@example.test", dateAdded: now, dateUpdated: now, dateContacted: twoHoursAgo)
        let prospect2 = Prospect(name: "Mary Prospect", emailAddress: "merrymary@example.test", dateAdded: twoHoursAgo, dateUpdated: twoHoursAgo, dateContacted: nil)

        modelContext.insert(prospect)
        modelContext.insert(prospect2)
    }
}
