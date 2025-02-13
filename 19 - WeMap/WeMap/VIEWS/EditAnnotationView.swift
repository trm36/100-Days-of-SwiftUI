//
//  EditAnnotationView.swift
//  WeMap
//
//  Created by Taylor Mott on 1/21/25.
//

import SwiftUI

struct EditAnnotationView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void

    @State private var name: String
    @State private var description: String

    @State private var loadingState: LoadingState = .loading
    @State private var pages = [Page]()


    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Location Name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("Nearby...") {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages) { page in
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
                    var newLocation = Location(from: location)
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    // MARK: - PLACES
    enum LoadingState {
        case loading, loaded, failed
    }

    private func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            fatalError("Bad URL - \(urlString)")
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let items = try JSONDecoder().decode(RequestResult.self, from: data)

            pages = items.query.pages.values.sorted() // we can use .sorted() because Page conforms to Comparable
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
}

#Preview {
    EditAnnotationView(location: .example, onSave: { _ in })
}
