//
//  RatingView.swift
//  WeBook
//
//  Created by Taylor on 2024-10-09.
//

import SwiftUI

struct RatingView: View {

    var label = ""
    @Binding var rating: Int

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }

            Spacer()

            // \.self gets rid of warning
            ForEach(1..<maximumRating + 1, id: \.self) { i in
                Button {
                    rating = i
                } label: {
                    image(for: i)
                        .foregroundStyle(i > rating ? offColor : onColor)
                }
                .buttonStyle(.plain)
            }

        }
    }

    private func image(for index: Int) -> Image {
        if index > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
