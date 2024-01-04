//
//  Logger.swift
//  NPad
//
//  Created by Jason on 2/1/2024.
//

import Foundation
import OSLog

enum Log {
    private static let logger = Logger()

    static func info(message: String) {
        logger.info("\(message)")
    }

    static func log(message: String) {
        logger.log("\(message)")
    }

    static func error(message: String) {
        logger.error("\(message)")
    }
}
