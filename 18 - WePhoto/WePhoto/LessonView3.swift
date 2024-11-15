//
//  LessonView3.swift
//  WePhoto
//
//  ShareLink
//  PhotosPicker
//  Request App Store review
//
//  Created by Taylor on 2024-11-15.
//

import PhotosUI
import StoreKit
import SwiftUI

struct LessonView3: View {
    @Environment(\.requestReview) var requestReview

    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerItems: [PhotosPickerItem] = []
    @State private var selectedImage: Image?


    var body: some View {
        VStack {
            Spacer()
            Spacer()

            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check out the 100 Days of SwiftUI!"))

            Spacer()

            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }

            Spacer()
            
            let example = Image(.example)
            ShareLink(item: example, preview: SharePreview("Flooded Canyon", image: example)) {
                Label("Click to share", systemImage: "tree")
            }
            
            Spacer()
            Spacer()

            selectedImage?
                .resizable()
                .scaledToFit()

            Spacer()
            
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            
            Spacer()
            
            PhotosPicker("Select a lot of pictures", selection: $pickerItems, maxSelectionCount: 3, matching: .all(of: [.images, .not(.screenshots)]))
            
            Spacer()
            Spacer()
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
            requestReview()
        }
        .onChange(of: pickerItems) { oldValue, newValue in
            Task {
                selectedImage = try await pickerItems.first?.loadTransferable(type: Image.self)
            }
            requestReview()
        }
    }
}

#Preview {
    LessonView3()
}
