//
//  CarDetailsUseCase.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation

protocol CarDetailsUseCaseDelegate {
    func getListOfCars() -> [CarDetailsModel]?
}

class CarDetailsUseCase: CarDetailsUseCaseDelegate {
    func getListOfCars() -> [CarDetailsModel]? {
        if let path = Bundle.main.path(forResource: "Test-vehicles_data", ofType: "json") {
            do {
                let carData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode([CarDetailsModel].self, from: carData)
                return decodedData
            } catch {
                print("Error during parsing")
            }
        }
        return nil
    }
}
