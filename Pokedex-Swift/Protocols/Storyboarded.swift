//
//  Storyboarded.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit

/// Define um protocolo para instanciação de itens desenvolvidos no Storyboard, via ID
/// não estando limitado somente a ViewControllers

protocol Storyboarded {
    
}

extension Storyboarded {
    
    static var identifier: String {
        
        let description = String(describing: self)
        let firstChar = description.first
        
        return String(describing: self).replacingCharacters(in: description.indices.first!...description.indices.first!, with: (firstChar?.lowercased())!)
    }
    
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate () -> Self {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: self.identifier) as! Self
        
    }
    
}
