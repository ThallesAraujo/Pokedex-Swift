//
//  UITestableViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 15/08/21.
//

import Foundation
import UIKit

protocol UITestableViewController {
    
    func setupUITestIdentifiers()
}

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self as? UITestableViewController)?.setupUITestIdentifiers()
    }
    
}
