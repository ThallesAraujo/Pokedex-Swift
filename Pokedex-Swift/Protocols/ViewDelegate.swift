//
//  ViewDelegate+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 09/07/21.
//

import Foundation
import UIKit
@objc protocol ViewDelegate{}

extension ViewDelegate{
    
    var navigationController: UINavigationController?{
        return (self as? UIViewController)?.navigationController
    }
    
}
