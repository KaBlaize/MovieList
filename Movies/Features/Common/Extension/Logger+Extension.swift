//
//  Logger+Extension.swift
//  Movies
//
//  Created by Balazs Kanyo on 22/10/2023.
//

import Foundation
import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "no.bundle.identifier.found"

    static let api = Logger(subsystem: subsystem, category: "api")
}
