//
//  CarDetailDataSource.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation
import UIKit

protocol CollectionViewScrollDelegate: AnyObject {
    func collectionViewScrolled()
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.collectionViewScrolled()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self)
          {
             return
          }
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            let cellWidth : CGFloat = collectionView.frame.width
//
//            let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
//            let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
//
//        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
//        }
}
