//
//  TextListViewModel.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import Combine
import Foundation

class TextEntriesViewModel: ObservableObject {
    @Published var textEntries: [TextEntryModel] = []

    // Handle changes in TextEntryFormViewModel
    func handleTextEntryChange(_ newEntry: TextEntryModel) {
        // Do something with the updated entry, e.g., add it to textEntries
        textEntries.append(newEntry)
    }
}
