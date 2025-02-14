//
//  ContentView.swift
//  WeMap
//
//  Created by Taylor Mott on 11/28/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                ZStack {
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
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
                                                viewModel.selectedPlace = location
                                            }
                                    )
                            }
                        }
                    }
                    .mapStyle(viewModel.mapAppearance.mapStyle)
                    .onTapGesture { position in
                        print("Tapped at screen possition \(position)")
                        guard let coordinate = proxy.convert(position, from: .local) else { return }
                        print("Tapped at coordinate \(coordinate)")
                        viewModel.addLocation(at: coordinate)
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditAnnotationView(location: place) { newLocation in
                            viewModel.updateLocation(location: newLocation)
                        }
                    }

                    VStack {
                        HStack {
                            Spacer()

                            VStack {
                                Button(action: viewModel.toggleMapAppearance) {
                                    if viewModel.mapAppearance == .hybrid {
                                        Image(systemName: "map.fill")
                                    } else {
                                        Image(systemName: "map")
                                    }
                                }
                            }
                            .padding()
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 12.0))
                        }

                        Spacer()
                    }
                    .padding()
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(isPresented: Binding<Bool>(
                    get: { self.viewModel.showingMissingAuthenticationErrorAlert },
                    set: { self.viewModel.showingMissingAuthenticationErrorAlert = $0 }
                )) {
                    Alert(title: Text("Enable Device Authentication"))
                }
                .alert(isPresented: Binding<Bool>(
                    get: { self.viewModel.showingFailedAuthenticationErrorAlert },
                    set: { self.viewModel.showingFailedAuthenticationErrorAlert = $0 }
                )) {
                    Alert(title: Text("Failed Device Authentication"),
                          message: Text("Please try authentication again."))
                }
        }
    }
}

#Preview {
    ContentView()
}
