//
//  CarDetailCollectionViewCell.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import UIKit

class CarDetailCollectionViewCell: BaseCell {
    @IBOutlet fileprivate weak var carImage: UIImageView!
    @IBOutlet fileprivate weak var carLicense: UILabel!
    @IBOutlet fileprivate weak var remainingKm: UILabel!
    @IBOutlet fileprivate weak var noOfSeats: UILabel!
    @IBOutlet fileprivate weak var rentalCost: UILabel!
    @IBOutlet fileprivate weak var carImageView: UIView!
    @IBOutlet weak var cardModel: UILabel!
    @IBOutlet weak var reserveCarButton: UIButton!
    weak var carReservationDelegate: CarReservationDelegate?
    var cardId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addRoundedEdgeAndShadow()
    }

    func setupCell(cellModel: CarDetailsCellModel) {
        cardId = cellModel.vehicleId?.description
        if let imageString = cellModel.carImage, let imageURL = URL(string: imageString) {
            // Download image if not present in cache, else use the cached image
            carImage.downloadImageFrom(url: imageURL)
        }
        if let cardIdValue = cellModel.vehicleId {
            let isCarAlreadyReserved = UserDefaults.standard.bool(forKey: cardIdValue.description)
            reserveCarButton.isEnabled = !isCarAlreadyReserved
        } else {
            reserveCarButton.isEnabled = true
        }
        reserveCarButton.setTitle(NSLocalizedString("reserve_car_btn_title", comment: ""), for: .normal)
        carLicense.text = cellModel.license
        remainingKm.text = cellModel.remainderRange
        noOfSeats.text = "4 seats" // hard-coded data
        rentalCost.text = "50¢/min" // hard-coded data
        cardModel.text = cellModel.model
    }
    
    // MARK: Add round corner and shadow around car image
    func addRoundedEdgeAndShadow() {
        carImageView.layer.cornerRadius = carImageView.frame.width/2.0
        carImageView.layer.shadowColor = UIColor.gray.cgColor
        carImageView.layer.shadowOpacity = 0.5
        carImageView.layer.shadowRadius = 4
        carImageView.layer.shadowOffset = CGSize.zero
    }
    
    @IBAction func reserveCarButtonTapped(_ sender: Any) {
        if let cardIdValue = cardId {
            UserDefaults.standard.set(true, forKey: cardIdValue)
        }
        reserveCarButton.isEnabled = false
        carReservationDelegate?.reserveCar()
    }
}
