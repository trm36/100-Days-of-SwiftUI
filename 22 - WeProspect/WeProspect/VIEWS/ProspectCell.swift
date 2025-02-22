//
//  ProspectCell.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-21.
//

import SwiftData
import SwiftUI

struct ProspectCell: View {

    let prospect: Prospect
    let showsContactedIndicator: Bool

    init(prospect: Prospect, showsContactedIndicator: Bool = false) {
        self.prospect = prospect
        self.showsContactedIndicator = showsContactedIndicator
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if showsContactedIndicator {
                Image(systemName: prospect.isContacted ? "checkmark.circle.fill" : "questionmark.diamond.fill")
                    .foregroundStyle(prospect.isContacted ? .green : .orange)
                    .scaleEffect(1.5)

            }
        }
        .tag(prospect)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prospect.self, configurations: config)

    let prospect = Prospect(name: "Jon Prospect", emailAddress: "jp@example.test")
    let prospect2 = Prospect(name: "Mary Prospect", emailAddress: "merrymary@example.test")

    NavigationStack {
        List {
            ProspectCell(prospect: prospect, showsContactedIndicator: true)
            ProspectCell(prospect: prospect2, showsContactedIndicator: true)
            ProspectCell(prospect: prospect, showsContactedIndicator: false)
        }
    }
    .modelContainer(container)
}
