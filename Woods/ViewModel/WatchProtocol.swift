//
//  WatchProtocol.swift
//  Woods
//
//  Created by Fredrik on 21.04.22.
//

import Foundation

/// A message used in communication with the watch.
protocol WatchProtocolMessage: Codable {
    static var key: WatchMessageKey<Self> { get }
}

/// The protocol structures used in communication with the watch.
enum WatchProtocol {
    struct NavigationTargetUpdate: WatchProtocolMessage {
        static let key = WatchMessageKey<Self>(rawValue: "woods.navigationTargetUpdate")
        
        var navigationTarget: Coordinates?
    }
}
