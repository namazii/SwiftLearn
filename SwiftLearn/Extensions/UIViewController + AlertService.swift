//
//  UIViewController + AlertService.swift
//  SwiftLearn
//
//  Created by Назар Ткаченко on 05.09.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
