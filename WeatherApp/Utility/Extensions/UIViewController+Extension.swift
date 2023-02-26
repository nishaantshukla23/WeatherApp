//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by N Shukla on 26/02/23.
//

import UIKit

extension UIViewController {

    /**
     This is method to hide keyboard when tapped around the view.
        * Uses Tap Gestrue to recognise the tap on view & invoke 'dismissKeyboard' method.
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /**
     This is method to hide keyboard when tapped around the view.
     */
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
 }
