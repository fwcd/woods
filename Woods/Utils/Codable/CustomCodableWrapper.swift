//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Wrapper type providing a Codable implementation for use with `CustomCodable`.
protocol CustomCodableWrapper<Wrapped>: Codable {
    /// The type of the underlying value being wrapped.
    associatedtype Wrapped

    /// The underlying value.
    var wrappedValue: Wrapped { get }

    /// Create a wrapper from an underlying value.
    init(wrappedValue: Wrapped)
}

extension Optional: CustomCodableWrapper where Wrapped: CustomCodableWrapper {
    var wrappedValue: Wrapped.Wrapped? { self?.wrappedValue }
    
    init(wrappedValue: Wrapped.Wrapped?) {
        self = wrappedValue.flatMap { Wrapped.init(wrappedValue: $0) }
    }
}
