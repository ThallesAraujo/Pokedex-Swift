//
//  HomeCoordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 13/11/21.
//

import Foundation
import UIKit
class HomeCoordinator: Coordinator {
   
    var navigation: UINavigationController?
    
    required init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func presentNextScreen(data: Any?) {
        
        guard let navigationController = self.navigation else {
            return
        }
        
        guard let vc = UIStoryboard.init(name: mainStoryboard, bundle: .main).instantiateViewController(identifier: pokemonDetailsViewController) as? PokemonDetailsViewController else {
            return
        }

        guard let pokemon = data as? Pokemon else {
            return
        }
        
        vc.pokemon = pokemon
        vc.coordinator = PokemonDetailsCoordinator(navigation: self.navigation)
        
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.pushViewController(vc, animated: true)
        
    }
    
}
