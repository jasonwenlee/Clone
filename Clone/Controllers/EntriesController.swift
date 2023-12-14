//
//  EntriesController.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import Combine
import Foundation

class EntriesController {
    static let shared = EntriesController()

    let textEntryFormViewModel = TextEntryFormViewModel()
    let textEntriesViewModel = TextEntriesViewModel()

    init() {
        setupBindings()
    }

    private func setupBindings() {
        // Observe changes in TextEntryFormViewModel
        textEntryFormViewModel.$textEntry
            .compactMap { $0 }
            .sink { [weak self] entry in
                // React to changes in TextEntryFormViewModel
                self?.textEntriesViewModel.handleTextEntryChange(entry)
            }
            .store(in: &cancellables)
    }

    func selectEntry(entry: TextEntry) {
        textEntryFormViewModel.textEntry = entry
    }

    private var cancellables: Set<AnyCancellable> = []
}
