//
//  AnnotationPopUpModel.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 11/11/21.
//

import Foundation
import CoreLocation

struct AnnotationModel {
    var locationCoordinate: CLLocationCoordinate2D
    var carId: Int
    var carModel: String
    var location: CLLocation
}
