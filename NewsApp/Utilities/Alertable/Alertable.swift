//
//  Alertable.swift
//  NewsApp
//
//  Created by AhmedFitoh on 7/16/21.
//

import UIKit


protocol Alertable {
    func showAlert(message: String, completionHandler: (()->())?)
}

extension Alertable where Self: UIViewController {
    func showAlert(message: String, completionHandler: (()->())?){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completionHandler?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
