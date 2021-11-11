//
//  BaseCell.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
