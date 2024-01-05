//
//  Operations.swift
//  NPad
//
//  Created by Jason on 13/12/2023.
//

import CoreData
import Foundation

enum Operations: EntryProtocol {
    static let context = PersistenceController.shared.container.viewContext

    static func addEntry(title: String?, description: String?) -> TextEntry {
        let textEntry = TextEntry(context: context)
        textEntry.id = UUID()
        textEntry.entry_title = title
        textEntry.entry_description = description
        Log.log(message: "Adding entry \(textEntry.id?.uuidString ?? "")")
        _save()
        return textEntry
    }

    static func updateEntry(id: UUID, updatedTitle: String?, updatedDescription: String?) -> TextEntry? {
        let textEntry = fetchEntry(id: id)
        textEntry?.entry_title = updatedTitle
        textEntry?.entry_description = updatedDescription
        Log.log(message: "Updating entry \(id)")
        _save()
        return textEntry
    }

    static func deleteEntry(entry: TextEntry) {
        context.delete(entry)
        Log.log(message: "Deleting entry \(entry.id?.uuidString ?? "") from database")
        _save()
    }

    static func fetchEntry(id: UUID) -> TextEntry? {
        let request: NSFetchRequest<TextEntry> = TextEntry.fetchRequest()
        do {
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            let entry = try context.fetch(request).first
            Log.log(message: "Fetched entry \(id) from database")
            return entry
        } catch {
            return nil
        }
    }

    static func fetchEntries() -> [TextEntry] {
        let request: NSFetchRequest<TextEntry> = TextEntry.fetchRequest()
        do {
            let entries = try context.fetch(request)
            Log.log(message: "Fetched entries from database")
            return entries
        } catch {
            return []
        }
    }

    static func addAttachments(entryId: UUID? = nil, urls: [URL]) -> [Attachment] {
        guard let textEntry = entryId == nil ? TextEntry(context: context) : fetchEntry(id: entryId!) else {
            Log.error(message: "Fail to add \(urls.count) attachments to entry \(entryId?.uuidString ?? "")")
            return []
        }

        let attachments = urls.map { url in
            let attachment = Attachment(context: context)
            attachment.entry_id = entryId
            attachment.filePath = url.standardizedFileURL
            attachment.fileName = url.lastPathComponent
            attachment.fileType = url.pathExtension
            Log.log(message: "Adding attachment \(attachment.fileName ?? "")")
            return attachment
        }

        let attachmentsToAdd = Set(attachments)
        textEntry.addToAttachments(attachmentsToAdd as NSSet)
        Log.log(message: "Added \(attachmentsToAdd.count) attachments to entry \(textEntry.id?.uuidString ?? "")")
        _save()

        return attachments
    }

    static func _save() {
        if context.hasChanges {
            do {
                try context.save()
                Log.log(message: "Saved changes in database")
            } catch {
                let nsError = error as NSError
                Log.error(message: "Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
