//
//  EditProspectView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-21.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Environment(\.dismiss) var dismiss

    let prospect: Prospect

    @State var name: String
    @State var emailAddress: String
    @State var isContacted: Bool
    @State var dateContacted: Date?
    @State var missingInformationAlertIsPresented: Bool = false

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .frame(height: 50.0)

                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .font(.title)
                    .frame(height: 50.0)
            }

            Section {
                Toggle(isOn: $isContacted) {
                    Text("Is contacted?")
                        .font(.title)
                        .bold()
                        .frame(height: 50.0)
                }.onChange(of: isContacted) { old, new in
                    if new {
                        dateContacted = .now
                    } else {
                        dateContacted = nil
                    }
                }

                if let dateContacted {
                    LabeledContent("Date Contacted", value: dateContacted.formatted(date: .long, time: .standard))
                        .font(.caption)
                } else {
                    LabeledContent("Date Contacted", value: "Never")
                        .font(.caption)
                }
            }

            Section {
                LabeledContent("Date Added", value: prospect.dateAdded.formatted(date: .long, time: .standard))
                LabeledContent("Date Updated", value: prospect.dateUpdated.formatted(date: .long, time: .standard))
            }
            .font(.caption)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !emailAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                        missingInformationAlertIsPresented = true
                        return
                    }

                    prospect.name = name
                    prospect.emailAddress = emailAddress
                    prospect.dateContacted = dateContacted
                    prospect.dateUpdated = Date()

                    dismiss()
                }
                .alert("Missing Information", isPresented: $missingInformationAlertIsPresented, actions: {
                    Button("OK") {}
                }, message: {
                    Text("Please ensure you have a name and email address entered for this prospect.")
                })
            }

            ToolbarItem(placement: .bottomBar) {
                VStack {
                    Text("Original Prospect Details")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .bold()
                    Text("\(prospect.name) - \(prospect.emailAddress)")
                        .font(.caption)
                }
            }
        }
    }

    init(prospect: Prospect) {
        self.prospect = prospect
        _name = .init(initialValue: prospect.name)
        _emailAddress = .init(initialValue: prospect.emailAddress)
        _isContacted = .init(initialValue: prospect.dateContacted != nil)
        _dateContacted = .init(initialValue: prospect.dateContacted)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prospect.self, configurations: config)

    let prospect = Prospect(name: "Test Prospect", emailAddress: "test@example.com", dateContacted: .now)

    NavigationStack {
        EditProspectView(prospect: prospect)
            .modelContainer(container)
    }
}
