//
//  Geocaches.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import OSLog
import Combine

private let log = Logger(subsystem: "Woods", category: "Geocaches")

class Geocaches: ObservableObject {
    @Published private(set) var geocaches: [String: Geocache] = [:] // by id (aka. GC code)
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    init(accounts: Accounts) {
        self.accounts = accounts
    }
    
    subscript(id: String) -> Geocache? {
        geocaches[id]
    }
    
    func refresh(with query: GeocachesInRadiusQuery) {
        log.info("Refreshing geocaches in a radius of \(query.radius) around \(query.center)")
        runningQueryTask = Publishers.MergeMany(accounts.connectors.values.map { $0.geocaches(for: query) })
            .collect()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not query geocaches: \(String(describing: error))")
                }
            } receiveValue: { [self] in
                let foundCaches = $0.flatMap { $0 }
                geocaches = Dictionary(uniqueKeysWithValues: foundCaches.map { ($0.id, $0) })
                log.info("Found \(foundCaches.count) geocache(s)")
            }
    }
}
