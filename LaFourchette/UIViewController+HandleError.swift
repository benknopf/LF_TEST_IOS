//
//  UIViewController+HandleError.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 26/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func handle(error: Error){
        if let error = error as? ApiError{
            presentAlertViewController(title: "", message: error.localizedDescription)
        }
    }
    
    func presentAlertViewController(title: String?, message: String?){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

