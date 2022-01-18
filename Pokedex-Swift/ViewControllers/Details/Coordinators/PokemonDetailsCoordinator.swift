//
//  PokemonDetailsCoordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 21/11/21.
//

import Foundation
import UIKit

class PokemonDetailsCoordinator: Coordinator {
    
    var navigation: Navigation?
    
    required init(navigation: Navigation?) {
        self.navigation = navigation
    }
    
    func presentNextScreen(data: Any?) {
        if let (coordinator, navigationData) = data as? (Coordinator, Species){
            coordinator.presentNextScreen(data: navigationData)
        }
    }
    
}
