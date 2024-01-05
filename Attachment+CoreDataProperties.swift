//
//  Attachment+CoreDataProperties.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//
//

import CoreData
import Foundation

public extension Attachment {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Attachment> {
        return NSFetchRequest<Attachment>(entityName: "Attachment")
    }

    @NSManaged var fileName: String?
    @NSManaged var filePath: URL?
    @NSManaged var fileType: String?
    @NSManaged var entry_id: UUID?
    @NSManaged var attachment_id: UUID?
}

extension Attachment: Identifiable {}
