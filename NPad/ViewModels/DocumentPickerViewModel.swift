//
//  DocumentPickerViewModel.swift
//  NPad
//
//  Created by Jason on 3/1/2024.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

class DocumentPickerViewModel: NSObject, ObservableObject, UIDocumentPickerDelegate {
    @Published var selectedFileURL: URL?
    private let contentTypes: [UTType] = [.pdf, .image, .rawImage, .text, .plainText]

    func openDocumentPicker(contentType: [UTType]? = nil) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: contentType == nil ? contentTypes : contentType!)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true

        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController?.present(documentPicker, animated: true, completion: nil)

        Log.log(message: "Opened file picker.")
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let firstURL = urls.first {
            selectedFileURL = firstURL
            Log.log(message: "Selected file: \(firstURL.relativePath)")
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        Log.log(message: "Cancelled file picking.")
    }
}
