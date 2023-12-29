//
//  TextListViewModel.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import Combine
import CoreData
import Foundation

class TextEntriesViewModel: ObservableObject {
    @Published var textEntries: [TextEntry] = []

    init() {
        let entries = Operations.fetchEntries()
        textEntries.append(contentsOf: entries)
    }

    // Handle changes in TextEntryFormViewModel
    func handleTextEntryChange(_ newEntry: TextEntry) {
        if let index = textEntries.firstIndex(of: newEntry) {
            // Replace the entry.
            textEntries[index] = newEntry
        } else {
            // Add the new entry.
            textEntries.append(newEntry)
        }
    }
}
