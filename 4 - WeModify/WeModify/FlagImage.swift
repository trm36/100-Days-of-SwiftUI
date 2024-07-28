//
//  FlagImage.swift
//  WeFlag
//
//  Created by Taylor on 7/28/24.
//

import SwiftUI

struct FlagImage: View {

    var image: Image

    var body: some View {
        image
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(image: Image("US"))
}

