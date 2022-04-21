//
//  WatchMessageKey.swift
//  Woods
//
//  Created by Fredrik on 21.04.22.
//

import Foundation

struct WatchMessageKey<Value>: RawRepresentable {
    let rawValue: String
}

extension Dictionary where Key == String, Value == Any {
    subscript(key: WatchMessageKey<Value>) -> Value? {
        get { self[key.rawValue] as Value? }
        set { self[key.rawValue] = newValue }
    }
}

