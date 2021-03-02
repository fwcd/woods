//
//  Degrees.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

/// An angle in degrees.
struct Degrees: AdditiveArithmetic, Hashable, Comparable, Codable, CustomStringConvertible {
    static var zero = Degrees()
    
    // Decimal degrees (internal representation)
    var totalDegrees: Double
    
    /// Degrees and decimal minutes
    var dm: (degrees: Int, minutes: Double) {
        get {
            let totalMinutes = totalDegrees * 60
            let minutes = totalMinutes.truncatingRemainder(dividingBy: 60)
            let degrees = Int(totalMinutes) / 60
            return (degrees: degrees, minutes: minutes)
        }
        set {
            totalDegrees = Double(newValue.degrees) + (newValue.minutes / 60)
        }
    }
    
    /// Degrees, minutes and decimal seconds
    var dms: (degrees: Int, minutes: Int, seconds: Double) {
        get {
            let (degrees, remTotalMinutes) = dm
            let remTotalSeconds = remTotalMinutes * 60
            let seconds = remTotalSeconds.truncatingRemainder(dividingBy: 60)
            let minutes = Int(remTotalSeconds) / 60
            return (degrees: degrees, minutes: minutes, seconds: seconds)
        }
        set {
            totalDegrees = Double(newValue.degrees) + (Double(newValue.minutes) / 60) + (newValue.seconds / 3600)
        }
    }
    
    /// The absolute value
    var magnitude: Degrees { Degrees(degrees: abs(totalDegrees)) }
    
    var description: String { String(format: "%d° %.3f'", dm.degrees, dm.minutes) }
    
    init() {
        self.init(degrees: 0)
    }
    
    init(degrees: Double) {
        totalDegrees = degrees
    }
    
    init(degrees: Int, minutes: Double) {
        self.init()
        dm = (degrees: degrees, minutes: minutes)
    }
    
    init(degrees: Int, minutes: Int, seconds: Double) {
        self.init()
        dms = (degrees: degrees, minutes: minutes, seconds: seconds)
    }
    
    static func +(lhs: Self, rhs: Self) -> Self {
        Self(degrees: lhs.totalDegrees + rhs.totalDegrees)
    }
    
    static func -(lhs: Self, rhs: Self) -> Self {
        Self(degrees: lhs.totalDegrees - rhs.totalDegrees)
    }
    
    static func +=(lhs: inout Self, rhs: Self) {
        lhs.totalDegrees += rhs.totalDegrees
    }
    
    static func -=(lhs: inout Self, rhs: Self) {
        lhs.totalDegrees -= rhs.totalDegrees
    }
    
    static func *(lhs: Self, factor: Double) -> Self {
        Self(degrees: lhs.totalDegrees * factor)
    }
    
    static func *(factor: Double, rhs: Self) -> Self {
        Self(degrees: rhs.totalDegrees * factor)
    }
    
    static func /(lhs: Self, divisor: Double) -> Self {
        Self(degrees: lhs.totalDegrees / divisor)
    }
    
    static func *=(lhs: inout Self, factor: Double) {
        lhs.totalDegrees *= factor
    }
    
    static func /=(lhs: inout Self, divisor: Double) {
        lhs.totalDegrees /= divisor
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.totalDegrees < rhs.totalDegrees
    }
    
    static prefix func -(lhs: Self) -> Self {
        Self(degrees: -lhs.totalDegrees)
    }
    
    mutating func negate() {
        totalDegrees.negate()
    }
}
