//
//  EntryModel.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import Foundation

struct TextEntryModel: Identifiable {
    let id = UUID()
    let text: String?
    let description: String?
}
