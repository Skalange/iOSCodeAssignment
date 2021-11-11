//
//  CarDetailsModel.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation

struct CarDetailsModel: Codable {
    var vehicleId: Int?
    var isActive: Bool?
    var isAvailable: Bool?
    var lat: Double?
    var lon: Double?
    var license: String?
    var remainderMileage: Int?
    var remainderRange: Int?
    var model: String?
    var carImage: String?
    
    enum CodingKeys: String, CodingKey {
        case vehicleId = "id"
        case isActive = "is_active"
        case isAvailable = "is_available"
        case lat
        case lon = "lng"
        case license = "license_plate_number"
        case remainderMileage = "remaining_mileage"
        case remainderRange = "remaining_range_in_meters"
        case model = "vehicle_make"
        case carImage = "vehicle_pic_absolute_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vehicleId = try values.decodeIfPresent(Int.self, forKey: .vehicleId)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        remainderMileage = try values.decodeIfPresent(Int.self, forKey: .remainderMileage)
        remainderRange = try values.decodeIfPresent(Int.self, forKey: .remainderRange)
        model = try values.decodeIfPresent(String.self, forKey: .model)
        carImage = try values.decodeIfPresent(String.self, forKey: .carImage)
    }
}
