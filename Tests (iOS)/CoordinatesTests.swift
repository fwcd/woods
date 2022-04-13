//
//  CoordinatesTests.swift
//  WoodsTests
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import XCTest
@testable import Woods

private let eps = 0.001

class CoordinatesTests: XCTestCase {
    func testHeading() {
        let a = Coordinates(latitude: 0, longitude: 0)
        let b = Coordinates(latitude: 0, longitude: 90)
        let c = Coordinates(latitude: 90, longitude: 0)
        let d = Coordinates(latitude: 90, longitude: 90)
        
        XCTAssertEqual(a.heading(to: b).totalDegrees, 90, accuracy: eps)
        XCTAssertEqual(a.heading(to: c).totalDegrees, 0, accuracy: eps)
        XCTAssertEqual(a.heading(to: d).totalDegrees, 0, accuracy: eps)
    }
}
