//
//  TextEntry+CoreDataProperties.swift
//  Clone
//
//  Created by Jason on 12/12/2023.
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
