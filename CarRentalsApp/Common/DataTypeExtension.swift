//
//  DataTypeExtension.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation

extension Int {
    func getDistanceInKm() -> String {
        let distanceKm = self/1000
        return "\(distanceKm) km"
    }
}
