//
//  CoordinateSpacePlaygroundView.swift
//  WeLayout
//
//  Created by Taylor on 2025-03-18.
//

import SwiftUI




struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    let size = 6.0

    var body: some View {
        HStack {
            Text("Left")
            ZStack{
                GeometryReader { proxy in
                    Text("Center")
                        .background(.blue)
                        .onTapGesture {
                            print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                            print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                            print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                        }


                    Color.white
                        .frame(width: size, height: size)
                        .position(x: proxy.frame(in: .global).midX - size / 2,
                                  y: proxy.frame(in: .global).midY - size / 2)

                    Color.white
                        .frame(width: 5, height: 5)
                        .position(x: proxy.frame(in: .named("Custom")).midX - size / 2,
                                  y: proxy.frame(in: .named("Custom")).midY - size / 2)

                    Color.white
                        .frame(width: 5, height: 5)
                        .position(x: proxy.frame(in: .local).midX - size / 2,
                                  y: proxy.frame(in: .local).midY - size / 2)
                }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct CoordinateSpacePlaygroundView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    CoordinateSpacePlaygroundView()
}
