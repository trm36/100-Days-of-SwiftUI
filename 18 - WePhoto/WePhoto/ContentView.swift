//
//  ContentView.swift
//  WePhoto
//
//  Created by Taylor on 2024-11-04.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {

    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview

    @State private var showingFilters = false

    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity: Float = 0.5
    private let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)

                Spacer()

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter", action: showFilterOptions)
                        .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                            Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                            Button("Edges") { setFilter(CIFilter.edges()) }
                            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                            Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                            Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                            Button("Vignette") { setFilter(CIFilter.vignette()) }
                            Button("Cancel", role: .cancel) { }
                        }

                    Spacer()

                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("WePhoto Image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("WePhoto")
        }
    }

    private func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self),
                  let inputImage = UIImage(data: imageData) else { return }

            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }

    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }

    private func showFilterOptions() {
        showingFilters = true
    }

    @MainActor private func setFilter(_ filter: CIFilter) {
        currentFilter = filter

        filterCount += 1

        if filterCount >= 5 {
            requestReview()
        }

        loadImage()
    }
}

#Preview {
    ContentView()
}
