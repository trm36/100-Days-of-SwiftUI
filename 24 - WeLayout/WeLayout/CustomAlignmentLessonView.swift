//
//  CustomAlignmentLessonView.swift
//  WeLayout
//
//  Created by Taylor on 2025-03-18.
//

import SwiftUI

struct CustomAlignmentLessonView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(.deervalley)
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)

            }
        }

        Text("Hello, world!")
//            .background(.red)
            .position(x: 100, y: 100)
            .background(.red)
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

#Preview {
    CustomAlignmentLessonView()
}
