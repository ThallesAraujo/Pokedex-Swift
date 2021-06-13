//
//  UIViewController+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 13/06/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func setTitleStyle(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Quicksand", size: 20)!]
    }
}
