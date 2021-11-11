//
//  CustomAnnotationPopUp.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 11/11/21.
//

import Foundation
import UIKit

class CustomAnnotationPopUp: UIView {
    @IBOutlet weak var carLicense: UILabel!
    @IBOutlet weak var carLocation: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func setupAnnotationView(model: AnnotationPopUpModel) {
//        carLicense.text = model.license
//        carLocation.text = model.address
//    }
}
