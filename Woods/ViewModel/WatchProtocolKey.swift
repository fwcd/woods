//
//  WatchProtocolKey.swift
//  Woods
//
//  Created by Fredrik on 21.04.22.
//

import Foundation

enum WatchProtocolKey {
    static let navigationTarget = WatchMessageKey<Coordinates?>(rawValue: "woods.navigationTarget")
}
