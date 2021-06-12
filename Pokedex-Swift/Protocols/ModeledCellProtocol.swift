//
//  ModeledCellProtocol.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import Foundation
import UIKit

protocol ModeledCell{
    
    associatedtype modelType
    
    func config(_ model: modelType)
    
}
