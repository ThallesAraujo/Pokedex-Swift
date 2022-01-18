//
//  NavigationSplitViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 18/01/22.
//

import Foundation
import UIKit

protocol Navigation{
    
    func pushViewController( _ viewController: UIViewController, animated: Bool)
    
}

extension UINavigationController: Navigation{
    
}


extension UISplitViewController: Navigation{
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.setViewController(viewController, for: .secondary)
    }
    
    
}
