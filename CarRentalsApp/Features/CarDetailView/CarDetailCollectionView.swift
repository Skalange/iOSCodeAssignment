//
//  CarDetailCollectionView.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation
import UIKit

protocol CarViewDelegate: AnyObject {
    func updateMapAnnotation(index: Int)
}

class CarDetailCollectionView: UICollectionView, CollectionViewScrollDelegate {
    var carDetailDataSource = CarDetailDataSource()
    weak var carViewDelegate: CarViewDelegate?
    weak var carReservationDelegate: CarReservationDelegate? {
        didSet {
            carDetailDataSource.carReservationDelegate = carReservationDelegate
        }
    }
    
    func collectionViewScrolled() {
        let currentCellIndexPath = ceil(self.contentOffset.x / self.frame.size.width)
         carViewDelegate?.updateMapAnnotation(index: Int(currentCellIndexPath))
     }
    
    var cellModel: [CarDetailsCellModel]? {
        set {
            carDetailDataSource.cellModel = newValue
            reloadData()
        }
        get {
            return carDetailDataSource.cellModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carDetailDataSource.delegate = self
        self.delegate = carDetailDataSource
        self.dataSource = carDetailDataSource
        self.register(CarDetailCollectionViewCell.nib, forCellWithReuseIdentifier: CarDetailCollectionViewCell.cellIdentifier)
    }
}
