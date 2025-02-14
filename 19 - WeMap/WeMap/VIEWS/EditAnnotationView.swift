//
//  EditAnnotationView.swift
//  WeMap
//
//  Created by Taylor Mott on 1/21/25.
//

import SwiftUI

struct EditAnnotationView: View {

    @EnvironmentObject private var viewModel: ViewModel

    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Location Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    let updatedLocation = viewModel.updateLocation()
                    onSave(updatedLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

#Preview {
    EditAnnotationView { _ in }
        .environmentObject(EditAnnotationView.ViewModel(location: .example))
}
