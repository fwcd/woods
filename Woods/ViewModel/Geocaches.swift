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
    @Published var geocaches: [Geocache] = []
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    init(accounts: Accounts) {
        self.accounts = accounts
    }
    
    func refresh(with query: GeocachesInRadiusQuery) {
        runningQueryTask = Publishers.MergeMany(accounts.connectors.values.map { $0.geocaches(for: query) })
            .collect()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not query geocaches: \(String(describing: error))")
                }
            } receiveValue: { [self] in
                geocaches = $0.flatMap { $0 }
            }
    }
}
