//
//  LessonView2.swift
//  WePhoto
//
//  CoreImage
//  ContentUnavailableView
//
//  Image from: @alexazabache - https://unsplash.com/@alexazabache
//
//  Created by Taylor on 2024-11-15.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct LessonView2: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            ContentUnavailableView {
                Label("No snippets", systemImage: "swift")
            } description: {
                Text("You don't have any saved snippets yet.")
            } actions: {
                Button("Create Snippet") {
                    // create a snippet
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        let filter = Filter.twirl
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)

        switch filter {
        case .sepia:
            let currentFilter = CIFilter.sepiaTone()
            currentFilter.inputImage = beginImage
            currentFilter.intensity = 0.5

            setImage(filter: currentFilter)
        case .pixelate:
            let currentFilter = CIFilter.pixellate()
            currentFilter.inputImage = beginImage
            currentFilter.scale = 100

            setImage(filter: currentFilter)
        case .twirlModern:
            let currentFilter = CIFilter.twirlDistortion()
            currentFilter.inputImage = beginImage
            currentFilter.radius = 1000
            currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)

            setImage(filter: currentFilter)

        case .twirl:
            let currentFilter = CIFilter.twirlDistortion()
            currentFilter.inputImage = beginImage

            let amount = 1.0

            let inputKeys = currentFilter.inputKeys

            if inputKeys.contains(kCIInputIntensityKey) {
                currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
            }

            if inputKeys.contains(kCIInputRadiusKey) {
                currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
            }

            if inputKeys.contains(kCIInputScaleKey) {
                currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
            }

            setImage(filter: currentFilter)
        }
    }

    func setImage(filter: CIFilter) {
        let context = CIContext()
        guard let outputImage = filter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }

    enum Filter {
        case sepia
        case pixelate
        case twirlModern
        case twirl
    }
}

#Preview {
    ContentView()
}


#Preview {
    LessonView2()
}
