//
//  DocumentPickerViewModel.swift
//  NPad
//
//  Created by Jason on 3/1/2024.
//

import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers

class DocumentPickerController: NSObject, ObservableObject, UIDocumentPickerDelegate {
    @Published var urls: [URL] = []
    // TODO: Add more content types.
    private let contentTypes: [UTType] = [.pdf]

    func openDocumentPicker(contentType: [UTType]? = nil) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: contentType == nil ? contentTypes : contentType!, asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true

        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController?.present(documentPicker, animated: true, completion: nil)

        Log.log(message: "Opened file picker")
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        self.urls = urls
        Log.log(message: "Selected \(urls.count) files")
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        Log.log(message: "Cancelled file picking")
    }
}
