//
//  TextListViewModel.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import Combine
import Foundation

class TextEntriesViewModel: ObservableObject {
    @Published var textEntries: [TextEntry] = []

    // Handle changes in TextEntryFormViewModel
    func handleTextEntryChange(_ newEntry: TextEntry) {
        // Do something with the updated entry, e.g., add it to textEntries
        textEntries.append(newEntry)
    }
}
