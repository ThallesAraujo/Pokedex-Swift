//
//  UIViewController+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 30/06/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = UIColor.init(named: "TitleColor")
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: {_ in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
