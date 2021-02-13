//
//  Length.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

struct Length {
    var meters: Double
    
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
