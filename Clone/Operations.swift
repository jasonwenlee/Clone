//
//  Operations.swift
//  Clone
//
//  Created by Jason on 13/12/2023.
//

import CoreData
import Foundation

struct Operations: EntryProtocol {
    static let context = PersistenceController.shared.container.viewContext

    static func saveEntry() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    static func fetchEntry(id: UUID) -> TextEntry? {
        let request: NSFetchRequest<TextEntry> = TextEntry.fetchRequest()
        do {
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            let entry = try context.fetch(request).first
            return entry
        } catch {
            return nil
        }
    }

    static func fetchEntries() -> [TextEntry] {
        let request: NSFetchRequest<TextEntry> = TextEntry.fetchRequest()
        do {
            let entries = try context.fetch(request)
            return entries
        } catch {
            return []
        }
    }
}
