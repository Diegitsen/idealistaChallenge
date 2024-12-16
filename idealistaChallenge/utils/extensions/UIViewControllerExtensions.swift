//
//  UIViewControllerExtensions.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import UIKit

extension UIViewController {
    
    func embedInUINavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
        
    func presentAlert(title: String? = nil, message: String? = nil, buttonText: String = "Aceptar", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: {_ in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
