//
//  DataUtils.swift
//  Woods
//
//  Created by Fredrik on 2/14/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import OSLog

private let log = Logger(subsystem: "Woods", category: "Utils")

extension Data {
    /// Reads a potentially security-scoped resource.
    static func smartContents(of url: URL) throws -> Data {
        do {
            return try Data(contentsOf: url)
        } catch {
            log.debug("Could not read \(url) directly, trying security-scoped access...")
            
            guard url.startAccessingSecurityScopedResource() else { throw PersistenceError.couldNotReadSecurityScoped }
            defer { url.stopAccessingSecurityScopedResource() }
            
            var error: NSError? = nil
            var caughtError: Error? = nil
            var data: Data? = nil
            
            NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { url2 in
                do {
                    data = try Data(contentsOf: url)
                } catch {
                    caughtError = error
                }
            }
            
            if let error = error {
                throw error
            } else if let caughtError = caughtError {
                throw caughtError
            }
            
            guard let unwrappedData = data else { throw PersistenceError.couldNotReadData }
            return unwrappedData
        }
    }
    
    /// Writes a resource.
    func smartWrite(to url: URL) throws {
        try write(to: url)
    }
}
