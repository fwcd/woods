//
//  Published+Extensions.swift
//  Woods
//
//  Created on 07.03.23
//

import Combine
import Foundation
import OSLog

private let encoder = JSONEncoder.standard()
private let decoder = JSONDecoder.standard()
private let persistenceEnabled = !isRunningInSwiftUIPreview()
private var subscriptions = [String: AnyCancellable]()

private let log = Logger(subsystem: "Woods", category: "Published+Extensions")

extension Published where Value: Codable {
    init(wrappedValue: Value, persistingTo path: String) {
        if persistenceEnabled {
            let url = persistenceFileURL(path: path)
            let save = { (value: Value) in
                do {
                    try encoder.encode(value).write(to: url)
                } catch {
                    log.error("Could not write to file")
                }
            }
            
            do {
                self.init(initialValue: try decoder.decode(Value.self, from: Data.smartContents(of: url)))
            } catch {
                log.debug("Could not read file: \(String(describing: error))")
                self.init(initialValue: wrappedValue)
            }
            
            subscriptions[path] = projectedValue.sink(receiveValue: save)
        } else {
            // If persistence is disabled (e.g. in testing/preview contexts),
            // just initialize the propery as usual.
            self.init(initialValue: wrappedValue)
        }
    }
}
