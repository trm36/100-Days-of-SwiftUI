//
//  MeView.swift
//  WeProspect
//
//  Created by Taylor on 2025-02-20.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = ""
    @AppStorage("emailAddress") private var emailAddress = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                        .frame(height: 50.0)
                    
                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)
                        .frame(height: 50.0)
                }

                if !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !emailAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Section {
                        Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .navigationTitle("Your code")
        }
    }

    // MARK: - QR CODES
    let context = CIContext()
    let qrFilter = CIFilter.qrCodeGenerator()

    private func generateQRCode(from string: String) -> UIImage {
        qrFilter.message = Data(string.utf8)

        guard let outputImage = qrFilter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }

        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    MeView()
}
