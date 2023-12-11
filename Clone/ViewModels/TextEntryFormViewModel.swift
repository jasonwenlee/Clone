//
//  TextEntryFormViewController.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import Foundation

class TextEntryFormViewModel: ObservableObject {
    @Published var textEntry: TextEntryModel?

    func addTextEntry(_ text: String?, _ description: String?) {
        textEntry = TextEntryModel(
            text: text,
            description: description
        )
    }
}
