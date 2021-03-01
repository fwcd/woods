//
//  Length.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

struct Length: AdditiveArithmetic, Hashable, Codable, CustomStringConvertible {
    static var zero = Length()
    
    var meters: Double
    var description: String { String(format: "%.2f m", meters) }
    
    init() {
        self.init(meters: 0)
    }
    
    init(meters: Double) {
        self.meters = meters
    }
    
    init(_ value: Double, _ unit: Unit) {
        meters = value * unit.rawValue
    }
    
    func `as`(_ unit: Unit) -> Double {
        meters / unit.rawValue
    }
    
    static func +(lhs: Self, rhs: Self) -> Self {
        Self(meters: lhs.meters + rhs.meters)
    }
    
    static func -(lhs: Self, rhs: Self) -> Self {
        Self(meters: lhs.meters - rhs.meters)
    }
    
    static func +=(lhs: inout Self, rhs: Self) {
        lhs.meters += rhs.meters
    }
    
    static func -=(lhs: inout Self, rhs: Self) {
        lhs.meters -= rhs.meters
    }
    
    static func *(lhs: Self, factor: Double) -> Self {
        Self(meters: lhs.meters * factor)
    }
    
    static func *(factor: Double, rhs: Self) -> Self {
        Self(meters: rhs.meters * factor)
    }
    
    static func /(lhs: Self, divisor: Double) -> Self {
        Self(meters: lhs.meters / divisor)
    }
    
    static func *=(lhs: inout Self, factor: Double) {
        lhs.meters *= factor
    }
    
    static func /=(lhs: inout Self, divisor: Double) {
        lhs.meters /= divisor
    }
    
    static prefix func -(lhs: Self) -> Self {
        Self(meters: -lhs.meters)
    }
    
    mutating func negate() {
        meters.negate()
    }
    
    enum Unit: Double {
        case kilometers = 1000
        case meters = 1
        case centimeters = 0.01
        case millimeters = 0.001
        case feet = 0.3048
        case inches = 0.0254
        case yards = 0.9144
        case miles = 1609.34
    }
}
