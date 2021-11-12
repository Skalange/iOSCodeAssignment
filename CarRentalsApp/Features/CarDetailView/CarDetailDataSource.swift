//
//  CarDetailDataSource.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation
import UIKit

protocol CollectionViewScrollDelegate: AnyObject {
    func collectionViewScrolled(scrollView: UIScrollView)
}

class CarDetailDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var cellModel: [CarDetailsCellModel]?
    weak var carReservationDelegate: CarReservationDelegate?
    weak var delegate: CollectionViewScrollDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellData = cellModel else {
            return 0
        }
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarDetailCollectionViewCell.cellIdentifier, for: indexPath) as? CarDetailCollectionViewCell, let model = cellModel else {
            return UICollectionViewCell()
        }
        cell.carReservationDelegate = carReservationDelegate
        cell.setupCell(cellModel: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width , height: 250)
    }
    
    //MARK: Function to identify when collection view has stopped scrolling and call a delegate method to update annotation on map based on the focused collection view row
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.collectionViewScrolled(scrollView: scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self)
          {
             return
          }
    }
}
