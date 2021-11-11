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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addRoundedEdgeAndShadow()
    }

    func setupCell(cellModel: CarDetailsCellModel) {
        if let imageString = cellModel.carImage, let imageURL = URL(string: imageString) {
            carImage.downloadImageFrom(url: imageURL)
        }
        reserveCarButton.setTitle("Reserve this car", for: .normal)
        carLicense.text = cellModel.license
        remainingKm.text = cellModel.remainderRange
        noOfSeats.text = "4 seats"
        rentalCost.text = "50¢/min"
        cardModel.text = cellModel.model
    }
    
    func addRoundedEdgeAndShadow() {
        carImageView.layer.cornerRadius = carImageView.frame.width/2.0
        carImageView.layer.shadowColor = UIColor.gray.cgColor
        carImageView.layer.shadowOpacity = 0.5
        carImageView.layer.shadowRadius = 4
        carImageView.layer.shadowOffset = CGSize.zero
    }
    
    @IBAction func reserveCarButtonTapped(_ sender: Any) {
        carReservationDelegate?.reserveCar()
    }
}
