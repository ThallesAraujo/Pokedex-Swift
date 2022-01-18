//
//  PokemonEvolutionCoordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 21/11/21.
//

import Foundation
import UIKit
import RxSwift

class PokemonEvolutionCoordinator: Coordinator {
    
    var navigation: Navigation?
    
    var disposeBag = DisposeBag()
    
    var service = HomeService()
    
    required init(navigation: Navigation?) {
        self.navigation = navigation
    }
    
    func presentNextScreen(data: Any?) {
        if let item = data as? Species {
            
            let fetchedPokemonEvolution = service.getPokemon(fromURL: item.url?.replacingOccurrences(of: "-species", with: "") ?? "")
                fetchedPokemonEvolution.subscribe(onNext: {pokemon in
                    if let viewController = UIStoryboard.init(name: mainStoryboard, bundle: .main).instantiateViewController(identifier: pokemonDetailsViewController) as? PokemonDetailsViewController {
                        
                        viewController.pokemon = pokemon
                        viewController.coordinator = PokemonDetailsCoordinator.init(navigation: self.navigation)
                        
                        self.navigation?.pushViewController(viewController, animated: true)
                        
                    }
                }).disposed(by: disposeBag)
            
        }
    }
    
}
