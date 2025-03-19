//
//  GeometryReaderPlaygroundView.swift
//  WeLayout
//
//  Created by Taylor on 2025-03-18.
//

import SwiftUI

struct GeometryReaderPlaygroundView: View {
    var body: some View {
//        HStack {
//            Text("IMPORTANT")
//                .frame(width: 200)
//                .background(.blue)
//
//            GeometryReader { proxy in
//                Image(.deervalley)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: proxy.size.width * 0.8)
//                    .frame(width: proxy.size.width, height: proxy.size.height)
//            }
//        }
//
//        GeometryReader { proxy in
//            Text("Hello, World!")
//                .frame(width: proxy.size.width * 0.9)
//                .background(.red)
//                .frame(width: proxy.size.width)
        //        }

        VStack {
            GeometryReader { proxy in
                Text("Hello, World!")
                    .frame(width: proxy.size.width * 0.9, height: 40)
                    .background(.red)
            }
            .background(.green)
            
            Text("More text")
                .background(.blue)
        }
    }
}

#Preview {
    GeometryReaderPlaygroundView()
}
