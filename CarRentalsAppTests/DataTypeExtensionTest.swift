//
//  DataTypeExtensionTest.swift
//  CarRentalsAppTests
//
//  Created by Sonali Kalange on 11/11/21.
//

import XCTest
@testable import CarRentalsApp

class DataTypeExtensionTest: XCTestCase {
    func testConversionToKm() {
        let distanceInMts = 42000
        let kmDistance = distanceInMts.getDistanceInKm()
        XCTAssertEqual(kmDistance, "42 km")
    }

}
