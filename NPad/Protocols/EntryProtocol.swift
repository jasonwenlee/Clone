//
//  entry.swift
//  NPad
//
//  Created by Jason on 13/12/2023.
//

import Foundation

protocol EntryProtocol {
    static func addEntry(title: String?, description: String?) -> TextEntry
    static func updateEntry(id: UUID, updatedTitle: String?, updatedDescription: String?) -> TextEntry?
    static func deleteEntry(entry: TextEntry)
    static func fetchEntry(id: UUID) -> TextEntry?
    static func fetchEntries() -> [TextEntry]
    static func addAttachments(entryId: UUID?, urls: [URL]) -> [Attachment]
}
