//
//  PopUpView.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 11/11/21.
//

import Foundation
import UIKit

class PopUpView: UIView {
    func displayPopUp(title: String, message: String, buttonTitle1: String?, buttonTitle2: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: buttonTitle1,
            style: .default,
            handler: nil)
        alertController.addAction(actionOk)
        return alertController
        //self.present(alertController, animated: true, completion: nil)
    }
}
