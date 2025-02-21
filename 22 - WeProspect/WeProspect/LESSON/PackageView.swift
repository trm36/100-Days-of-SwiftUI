//
//  PackageView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import SamplePackage
import SwiftUI

struct PackageView: View {

    let possibleNumbers = 1...60
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }

    var body: some View {
        Text(results)
    }
}

#Preview {
    PackageView()
}
