//
//  CompareUtils.swift
//  Woods
//
//  Created by Fredrik on 17.04.22.
//

/// A higher-order function that produces an ascending comparator
/// (as used by sorted(by:)) comparing a specific property.
public func ascendingComparator<T, P>(comparing property: @escaping (T) -> P) -> (T, T) -> Bool
    where P: Comparable {
    { property($0) < property($1) }
}
