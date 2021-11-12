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
    
    func collectionViewScrolled(scrollView: UIScrollView) {
        let currentCellIndexPath = ceil(self.contentOffset.x / self.frame.size.width)
        scrollToCentre(scrollView: scrollView)
         carViewDelegate?.updateMapAnnotation(index: Int(currentCellIndexPath))
     }
    
    //MARK: Centre collection view item in centre
    func scrollToCentre(scrollView: UIScrollView) {
        let centreItem = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: scrollView.frame.height / 2)
        let indexPath = self.indexPathForItem(at: centreItem) ?? IndexPath(row: 0, section: 0)
        if self.dataSource?.collectionView(self, cellForItemAt: indexPath) != nil {
            let rect = self.layoutAttributesForItem(at: indexPath)?.frame
                self.scrollRectToVisible(rect!, animated: true)
            }
    }
}
