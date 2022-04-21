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
    subscript<ConcreteValue>(key: WatchMessageKey<ConcreteValue>) -> ConcreteValue? {
        get { self[key.rawValue] as! ConcreteValue? }
        set { self[key.rawValue] = newValue }
    }
}

