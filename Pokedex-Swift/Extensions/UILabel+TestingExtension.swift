//
//  UITableViewCell+TestingExtension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 08/08/21.
//

import Foundation
import UIKit

extension UILabel{
    
    func setTestingIdentifier(_ acessibilityIdentifier: String){
        self.accessibilityLabel = accessibilityIdentifier
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isAccessibilityElement = true
    }
    
}
