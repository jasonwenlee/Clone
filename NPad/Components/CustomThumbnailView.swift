//
//  CustomThumbnailView.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//

import QuickLookThumbnailing
import SwiftUI

struct CustomThumbnailView: View {
    @State private var thumbnail: UIImage?
    let attachment: Attachment
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
                generateThumbnail(for: attachment) { generatedThumbnail in
                    thumbnail = generatedThumbnail
                    Log.log(message: "Use generated thumbnail")
                }
            }
    }

    private func generateThumbnail(for attachment: Attachment, completion: @escaping (UIImage?) -> Void) {
        guard let fileURL = attachment.filePath else {
            completion(nil)
            return
        }

        let scale = UIScreen.main.scale

        let request = QLThumbnailGenerator.Request(fileAt: fileURL, size: thumbnailScale!, scale: scale, representationTypes: .all)
        let generator = QLThumbnailGenerator.shared

        generator.generateBestRepresentation(for: request) { thumbnail, error in
            if let t = thumbnail {
                DispatchQueue.main.async {
                    Log.log(message: "Thumbnail for \(fileURL.relativePath) generated")
                    completion(t.uiImage)
                }

            } else {
                Log.error(message: "Error generating thumbnail: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}
