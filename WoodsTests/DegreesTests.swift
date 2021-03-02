//
//  DegreesTests.swift
//  WoodsTests
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import XCTest
@testable import Woods

private let eps = 0.01

class DegreesTests: XCTestCase {
    func testDegrees() {
        var d = Degrees(degrees: 23, minutes: 3, seconds: 5)
        
        XCTAssertEqual(d.totalDegrees, 23.05139, accuracy: eps)
        
        XCTAssertEqual(d.dms.degrees, 23)
        XCTAssertEqual(d.dms.minutes, 3)
        XCTAssertEqual(d.dms.seconds, 5, accuracy: eps)
        
        XCTAssertEqual(d.dm.degrees, 23)
        XCTAssertEqual(d.dm.minutes, 3.0833, accuracy: eps)
        
        d = Degrees(degrees: 23, minutes: 15.2)
        
        XCTAssertEqual(d.totalDegrees, 23.25333, accuracy: eps)
        
        XCTAssertEqual(d.dms.degrees, 23)
        XCTAssertEqual(d.dms.minutes, 15)
        XCTAssertEqual(d.dms.seconds, 12, accuracy: eps)
        
        XCTAssertEqual(d.dm.degrees, 23)
        XCTAssertEqual(d.dm.minutes, 15.2, accuracy: eps)
        
        d = Degrees(degrees: -164.754167)
        
        XCTAssertEqual(d.dms.degrees, -164)
        XCTAssertEqual(d.dms.minutes, -45)
        XCTAssertEqual(d.dms.seconds, -15, accuracy: eps)
        
        XCTAssertEqual(d.dm.degrees, -164)
        XCTAssertEqual(d.dm.minutes, -45.25, accuracy: eps)
    }
}
