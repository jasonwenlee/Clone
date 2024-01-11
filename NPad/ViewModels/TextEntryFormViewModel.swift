//
//  TextEntryFormViewController.swift
//  NPad
//
//  Created by Jason on 11/12/2023.
//

import CoreData
import Foundation

class TextEntryFormViewModel: ObservableObject {
    @Published var textEntry: TextEntry?

    func addTextEntry(title: String?, description: String?) {
        textEntry = Operations.addEntry(title: title, description: description)
    }

    func updateTextEntry(id: UUID, title: String?, description: String?) {
        textEntry = Operations.updateEntry(id: id, updatedTitle: title, updatedDescription: description)
    }

    func deleteTextEntry(entry: TextEntry) {
        Operations.deleteEntry(entry: entry)
        textEntry = nil
    }

    func addAttachments(id: UUID? = nil, urls: [URL]) {
        textEntry = Operations.addAttachments(entryId: id, urls: urls)
    }
}
