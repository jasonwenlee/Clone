//
//  TextEntry+CoreDataProperties.swift
//  NPad
//
//  Created by Jason on 3/1/2024.
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
}

extension TextEntry: Identifiable {}
