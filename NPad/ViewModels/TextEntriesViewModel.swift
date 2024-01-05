//
//  TextListViewModel.swift
//  NPad
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
        Log.log(message: "Initialised TextEntriesViewModel")
    }

    // Handle changes in TextEntryFormViewModel
    func handleTextEntryChange(_ newEntry: TextEntry?) {
        if let entry = newEntry {
            if let index = textEntries.firstIndex(of: entry) {
                // Replace the entry.
                textEntries[index] = entry
                Log.log(message: "Updated existing entry in entries list")
            } else {
                // Add the new entry.
                textEntries.append(entry)
                Log.log(message: "Added new entry in entries list")
            }
        } else {
            // Fetch latest entries from database.
            textEntries = Operations.fetchEntries()
            Log.log(message: "Populated entries list with latest entries")
        }
    }
}
