//
//  EditAnnotationView-ViewModel.swift
//  WeMap
//
//  Created by Taylor on 2025-02-14.
//

import Foundation
import SwiftUI

extension EditAnnotationView {

    @MainActor
    class ViewModel: ObservableObject {
        var location: Location

        @Published var name: String
        @Published var description: String

        @Published var loadingState: LoadingState = .loading
        @Published var pages = [Page]()

        init(location: Location) {
            self.location = location

            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }

        // MARK: - SAVE
        func updateLocation() -> Location {
            var updatedLocation = Location(from: location)
            updatedLocation.name = name
            updatedLocation.description = description
            return updatedLocation
        }

        // MARK: - PLACES
        enum LoadingState {
            case loading, loaded, failed
        }

        func fetchNearbyPlaces() async {
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
}
