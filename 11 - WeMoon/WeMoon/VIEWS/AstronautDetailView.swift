//
//  AstronautDetailView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-24.
//

import SwiftUI

struct AstronautDetailView: View {
    let astronaut: Astronaut
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(astronaut.imageName)
                        .resizable()
                        .scaledToFit()
                    
                    Text(astronaut.description)
                        .padding()
                }
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
        }
    }
}

#Preview {
    let astronaut = DataController.shared.astronauts.first!
    return AstronautDetailView(astronaut: astronaut.value)
        .preferredColorScheme(.dark)
}
