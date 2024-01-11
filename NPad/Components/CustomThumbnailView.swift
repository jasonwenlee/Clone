//
//  CustomThumbnailView.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//
import QuickLook
import QuickLookThumbnailing
import SwiftUI

struct CustomThumbnailView: View {
    @State private var thumbnail: UIImage?
    @State private var selectedURL: URL?

    let attachmentURL: URL
    let thumbnailScale: CGSize? = CGSize(width: 100, height: 100)

    var body: some View {
        Image(uiImage: thumbnail ?? UIImage(systemName: "exclamationmark.circle")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: thumbnailScale!.width, height: thumbnailScale!.height)
            .shadow(radius: 5)
            .cornerRadius(8)
            .padding(.horizontal, 4)
            .onAppear {
                generateThumbnail(for: attachmentURL) { generatedThumbnail in
                    thumbnail = generatedThumbnail
                }
            }.onTapGesture {
                selectedURL = attachmentURL
            }.quickLookPreview($selectedURL)
    }

    private func generateThumbnail(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let scale = UIScreen.main.scale

        let request = QLThumbnailGenerator.Request(fileAt: url, size: thumbnailScale!, scale: scale, representationTypes: .all)
        let generator = QLThumbnailGenerator.shared

        generator.generateBestRepresentation(for: request) { thumbnail, error in
            if let t = thumbnail {
                DispatchQueue.main.async {
                    completion(t.uiImage)
                }
            } else {
                Log.error(message: "Error generating thumbnail: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}
