//
//  entry.swift
//  Clone
//
//  Created by Jason on 13/12/2023.
//

import Foundation

protocol EntryProtocol {
    static func saveEntry()
    static func fetchEntry(id: UUID) -> TextEntry?
    static func fetchEntries() -> [TextEntry]
}
