//
//  Coordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 13/11/21.
//

import Foundation
import UIKit
protocol Coordinator{
    
    var navigation: UINavigationController? {get set}
    
    func presentNextScreen(data: Any?)
    
}
