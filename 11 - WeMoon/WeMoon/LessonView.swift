//
//  ContentView.swift
//  WeMoon
//
//  Created by Taylor on 2024-09-21.
//

import SwiftUI

struct LessonView: View {

    @State private var displayString: String = ""

    var body: some View {
        //        VStack {
        //            Image("example")
        //                .resizable()
        //                .scaledToFit()
        //                .containerRelativeFrame(.horizontal) { size, axis in
        //                        size * 0.8
        //                    }
        ////                .clipped()
        //        }
        //    }

        //        ScrollView {
        //            VStack(spacing: 10) {
        //                ForEach(0..<100) {
        //                    Text("Item \($0)")
        //                        .font(.title)
        //                }
        //            }
        //            .frame(maxWidth: .infinity)
        //        }

//        NavigationStack {
//            List(0..<100) { row in
//                NavigationLink {
//                    Text("Detail \(row)")
//                } label: {
//                    VStack {
//                        Text("This is the label on row \(row)")
//                        if row == 0 {
//                            Text("So is this")
//                            Image(systemName: "face.smiling")
//                        }
//                    }
//                }
//            }
//            .navigationTitle("SwiftUI")
//        }

//        VStack {
//            Button("Decode JSON") {
//                let input = """
//                {
//                    "name": "Taylor Swift",
//                    "address": {
//                        "street": "555, Taylor Swift Avenue",
//                        "city": "Nashville"
//                    }
//                }
//                """
//                
//                let data = Data(input.utf8)
//                if let user = try? JSONDecoder().decode(User.self, from: data) {
//                    let street = user.address.street
//                    displayString = street
//                    print(street)
//                }
//            }
//
//            Text(displayString)
//        }

        let layoutFixed = [
            GridItem(.fixed(80)),
            GridItem(.fixed(80)),
            GridItem(.fixed(80)),
        ]

        let layoutAdaptive = [
            GridItem(.adaptive(minimum: 80.0)),
        ]

        ScrollView {
            LazyVGrid(columns: layoutAdaptive) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

#Preview {
    LessonView()
}
