//
//  ReloadableViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 19/06/21.
//

import Foundation
import UIKit
protocol ReloadableViewController: UIViewController{
    
    var retryView: ErrorView? {get set}
    
    func reload()
    
}
