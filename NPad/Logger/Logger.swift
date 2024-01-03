//
//  Logger.swift
//  NPad
//
//  Created by Jason on 2/1/2024.
//

import Foundation
import OSLog

enum Log {
    static let _logger = Logger()

    static func info(message: String) {
        _logger.info("\(message)")
    }

    static func log(message: String) {
        _logger.log("\(message)")
    }

    static func error(message: String) {
        _logger.error("\(message)")
    }
}
