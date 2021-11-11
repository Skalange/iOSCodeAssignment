//
//  MainViewModelTest.swift
//  CarRentalsAppTests
//
//  Created by Sonali Kalange on 11/11/21.
//

import XCTest
@testable import CarRentalsApp
import CoreLocation

class MainViewTest: XCTestCase {
    private var viewModel: MainViewModel?
    
    override func setUp() {
        let useCase = CarDetailsUseCase()
        viewModel = MainViewModel(useCase: useCase)
    }

    func testGetCarData() {
        let carData = viewModel?.getCarTypes()
        XCTAssert((carData?.count ?? 0) > 0, "Retrieved car data")
    }
    
    func testGetAddress() {
        var addressValue: String?
        let location = CLLocation(latitude: 20.593, longitude: 78.962)
        let expectation = self.expectation(description: "Reverse GeoCoding")
        viewModel?.getAddress(location: location, completion: { address in
            if let addressString = address, !addressString.isEmpty {
                addressValue = addressString
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("Station Road\nWardha 442305\nMH\nIndia", addressValue)
    }
}
