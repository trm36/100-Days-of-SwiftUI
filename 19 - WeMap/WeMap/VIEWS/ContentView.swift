//
//  ContentView.swift
//  WeMap
//
//  Created by Taylor Mott on 11/28/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    //                        Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44.0, height: 44.0)
                            .background(.white)
                            .clipShape(.circle)
                            .simultaneousGesture(
                                LongPressGesture(minimumDuration: 1.0)
                                    .onEnded { _ in
                                        selectedPlace = location
                                    }
                            )
                    }
                }
            }
            .onTapGesture { position in
                print("Tapped at screen possition \(position)")
                guard let coordinate = proxy.convert(position, from: .local) else { return }
                print("Tapped at coordinate \(coordinate)")
                let newLocation = Location(name: "New Location", description: "Add description", latitude: coordinate.latitude, longitude: coordinate.longitude)
                locations.append(newLocation)
            }
            .sheet(item: $selectedPlace) { place in
                EditAnnotationView(location: place) { newLocation in
                    guard let index = locations.firstIndex(of: place) else { return }
                    locations[index] = newLocation
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
