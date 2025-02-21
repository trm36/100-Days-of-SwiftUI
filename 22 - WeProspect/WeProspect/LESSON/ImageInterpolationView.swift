//
//  ImageInterpolationView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SwiftUI

struct ImageInterpolationView: View {
    var body: some View {
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)

    }
}

#Preview {
    ImageInterpolationView()
}
