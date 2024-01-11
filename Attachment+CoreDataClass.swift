//
//  Attachment+CoreDataClass.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//
//

import CoreData
import Foundation

@objc(Attachment)
public class Attachment: NSManagedObject {
    var tofilePathURL: URL? { return filePath?.convertToURL() }
}
