//
//  PokemonTypeCoordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 21/11/21.
//

import Foundation
import UIKit

class PokemonTypeCoordinator: Coordinator {
    
    var navigation: Navigation?
    
    func presentNextScreen(data: Any?) {
        
        if let pokemon = data as? Pokemon {
            
            guard let vc = UIStoryboard.init(name: mainStoryboard, bundle: .main).instantiateViewController(identifier: pokemonDetailsViewController) as? PokemonDetailsViewController else {
                return
            }
            
            vc.pokemon = pokemon
            vc.coordinator = PokemonDetailsCoordinator.init(navigation: self.navigation)
            
            (navigation as? UINavigationController)?.navigationItem.largeTitleDisplayMode = .always
            navigation?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    required init(navigation: Navigation?) {
        self.navigation = navigation
    }
    
}
