//
//  TextEntryFormViewController.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import CoreData
import Foundation
import UIKit

class TextEntryFormViewModel: ObservableObject {
    @Published var textEntry: TextEntry?

    func addTextEntry(_ title: String?, _ description: String?) {
        textEntry = TextEntry(context: Operations.context)
        textEntry?.id = UUID()
        textEntry?.entry_title = title
        textEntry?.entry_description = description

        Operations.saveEntry()
    }
}
