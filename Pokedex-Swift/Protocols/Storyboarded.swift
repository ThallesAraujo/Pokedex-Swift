//
//  Storyboarded.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
protocol Storyboarded {
    
}
extension Storyboarded {
    
    static var identifier: String {
        
        let description = String(describing: self)
        let firstChar = description.first
        
        return String(describing: self).replacingCharacters(in: description.indices.first!...description.indices.first!, with: (firstChar?.lowercased())!)
    }
    
}
