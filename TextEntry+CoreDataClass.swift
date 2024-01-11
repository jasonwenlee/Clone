//
//  TextEntry+CoreDataClass.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//
//

import CoreData
import Foundation

@objc(TextEntry)
public class TextEntry: NSManagedObject {
    var attachmentURLs: [URL] {
        guard let attachmentsSet = attachments else {
            return []
        }

        let attachments = Array(attachmentsSet) as? [Attachment] ?? []

        return attachments.compactMap { e in e.tofilePathURL }
    }
}
