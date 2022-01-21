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


//TODO: Ao mover o código inteiro para ViewCode, renomear o protocolo
protocol Storyboarded {
    
}

extension Storyboarded {
    
    /**Define um identificador automático para itens que necessitam do mesmo
        Por padrão, todos os identificadores do app devem ser o nome da classe com
        primeira letra minúscula
     */
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
