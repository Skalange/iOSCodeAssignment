//
//  MainViewModel.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation
import Contacts
import MapKit

class MainViewModel {
    var useCase: CarDetailsUseCase?
    var successObserver: ((String?) -> Void)?
    
    init(useCase: CarDetailsUseCase) {
        self.useCase = useCase
    }
    
    func getCarTypes() -> [CarDetailsCellModel]? {
        guard let carListData = useCase?.getListOfCars() else {
            return nil
        }
        var cellModelData = [CarDetailsCellModel]()
        
        for car in carListData {
            let carCellModel = CarDetailsCellModel(vehicleId: car.vehicleId, isActive: car.isActive, isAvailable: car.isAvailable, lat: car.lat, lon: car.lon, license: car.license, remainderMileage: car.remainderMileage, remainderRange: car.remainderRange?.getDistanceInKm(), model: car.model, carImage: car.carImage)
            cellModelData.append(carCellModel)
        }
        return cellModelData
    }
    
    func getAddress(location: CLLocation, completion: @escaping (String?) -> Void) {
        var addressString: String?
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: nil) { (clPlacemark: [CLPlacemark]?, error: Error?) in
                guard let place = clPlacemark?.first else {
                    print("No placemark identified: \(String(describing: error))")
                    completion(nil)
                    return
                }

                let postalAddressFormatter = CNPostalAddressFormatter()
                postalAddressFormatter.style = .mailingAddress
                if let postalAddress = place.postalAddress {
                    addressString = postalAddressFormatter.string(from: postalAddress)
                    completion(addressString)
                }
        }
    }
    
    func getCoordinatesOfAllVehicles(cellModels: [CarDetailsCellModel]?) -> [AnnotationModel]? {
        guard let cellModel = cellModels else {
            return nil
        }
        var annotations = [AnnotationModel]()
        for model in cellModel {
            let annotationModel = AnnotationModel(locationCoordinate: CLLocationCoordinate2D(latitude: model.lat ?? 0.0, longitude: model.lon ?? 0.0), carId: model.vehicleId ?? 0, carModel: model.model ?? "", location: CLLocation(latitude: model.lat ?? 0.0, longitude: model.lon ?? 0.0))
            annotations.append(annotationModel)
        }
        return annotations
    }
}
