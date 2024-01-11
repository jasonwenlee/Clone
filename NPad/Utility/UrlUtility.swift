//
//  UrlUtility.swift
//  NPad
//
//  Created by Jason on 8/1/2024.
//

import Foundation

extension URL {
    func relativePathAsString() -> String? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        let components = documentsDirectoryURL.pathComponents
        let otherComponents = pathComponents

        guard components.count < otherComponents.count else { return nil }

        let remainingComponents = otherComponents.suffix(from: components.count)
        // asCopy is enabled in UIDocumentPickerViewController. This creates a file in a tmp directory.
        // This filter removes the tmp from the replative path.
        let filteredComponents = remainingComponents.filter { $0.lowercased() != "tmp" }

        return filteredComponents.joined(separator: "/")
    }

    func convertToDocumentDirectory(id: String? = nil) -> URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        guard let relativePath = relativePathAsString() else { return nil }

        if let id = id, !id.isEmpty {
            return documentsDirectoryURL.appendingPathComponent(id).appendingPathComponent(relativePath)
        }

        return documentsDirectoryURL.appendingPathComponent(relativePath)
    }
}

extension String {
    func convertToURL() -> URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        return documentsDirectoryURL.appendingPathComponent(self)
    }
}
