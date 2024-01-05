//
//  TextEntry+CoreDataProperties.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//
//

import CoreData
import Foundation

public extension TextEntry {
    @nonobjc class func fetchRequest() -> NSFetchRequest<TextEntry> {
        return NSFetchRequest<TextEntry>(entityName: "TextEntry")
    }

    @NSManaged var entry_description: String?
    @NSManaged var entry_title: String?
    @NSManaged var id: UUID?
    @NSManaged var attachments: NSSet?
    var attachmentsArray: [Attachment] {
        guard let attachmentsSet = attachments else {
            return []
        }
        return Array(attachmentsSet) as? [Attachment] ?? []
    }
}

// MARK: Generated accessors for attachments

public extension TextEntry {
    @objc(addAttachmentsObject:)
    @NSManaged func addToAttachments(_ value: Attachment)

    @objc(removeAttachmentsObject:)
    @NSManaged func removeFromAttachments(_ value: Attachment)

    @objc(addAttachments:)
    @NSManaged func addToAttachments(_ values: NSSet)

    @objc(removeAttachments:)
    @NSManaged func removeFromAttachments(_ values: NSSet)
}

extension TextEntry: Identifiable {}
