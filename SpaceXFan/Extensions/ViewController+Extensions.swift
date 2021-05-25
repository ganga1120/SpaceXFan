//
//  ViewController+Extensions.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Alert.ok, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
