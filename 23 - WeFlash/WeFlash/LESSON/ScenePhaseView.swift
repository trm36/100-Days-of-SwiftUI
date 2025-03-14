//
//  ScenePhaseView.swift
//  WeFlash
//
//  Created by Taylor on 2025-03-13.
//

import SwiftUI

struct ScenePhaseView: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, world!")
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    ScenePhaseView()
}
