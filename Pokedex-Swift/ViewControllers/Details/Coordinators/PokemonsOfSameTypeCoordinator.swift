//
//  PokemonsOfSameTypeCoordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 21/11/21.
//

import Foundation
import UIKit

class PokemonsOfSameTypeCoordinator: Coordinator {
    
    var navigation: Navigation?
    
    required init(navigation: Navigation?) {
        self.navigation = navigation
    }
    
    func presentNextScreen(data: Any?) {
        
        if let viewController = UIStoryboard.init(name: mainStoryboard, bundle: .main).instantiateViewController(identifier: typePokemonViewController) as? TypePokemonsViewController, let item = data as? Species {
            viewController.title = item.name?.capitalized
            
            let viewModel = TypePokemonsViewModel.init()
            viewModel.pokemonType = item
            viewController.viewModel = viewModel
            viewController.coordinator = PokemonTypeCoordinator.init(navigation: self.navigation)
            
            navigation?.pushViewController(viewController, animated: true)
        }
    }
    
}
