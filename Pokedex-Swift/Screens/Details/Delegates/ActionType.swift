//
//  ActionType.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 11/07/21.
//

import Foundation
import UIKit
import RxSwift

enum ActionType{
    
    case pokemonsOfSameType
    case seeEvolution
    case seeAbility
    
    func didTapAction(item: Species, navigation: UINavigationController?, disposeBag: DisposeBag){
        switch self{
            
        case .pokemonsOfSameType:
            
            if let viewController = UIStoryboard.init(name: Constants.mainStoryboard, bundle: .main).instantiateViewController(identifier: TypePokemonsViewController.identifier) as? TypePokemonsViewController{
                viewController.title = item.name?.capitalized
                
                let viewModel = TypePokemonsViewModel.init()
                viewModel.pokemonType = item
                viewController.viewModel = viewModel
                navigation?.pushViewController(viewController, animated: true)
            }
        case .seeAbility:
            
            let details = DetailsService.getAbility(fromURL: item.url ?? "")
            let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
                
                details.subscribe(onNext: {detail in
                    let abilityName = item.name?.capitalized ?? ""
                    let message = detail.flavorTextEntries?.first(where: {$0.language?.name == Constants.defaultLanguage})?.flavorText ?? ""
                    
                    if !abilityName.isEmpty && !message.isEmpty{
                        keyWindow?.rootViewController?.showAlert(title: abilityName.capitalized, message: message)
                    }
                    
                }).disposed(by: disposeBag)
            
        case .seeEvolution:
            
            let fetchedPokemonEvolution = HomeService.getPokemon(fromURL: item.url?.replacingOccurrences(of: "-species", with: "") ?? "")
                fetchedPokemonEvolution.subscribe(onNext: {pokemon in
                    if let viewController = UIStoryboard.init(name: Constants.mainStoryboard, bundle: .main).instantiateViewController(identifier: PokemonDetailsViewController.identifier) as? PokemonDetailsViewController{
                        
                        viewController.pokemon = pokemon
                        navigation?.pushViewController(viewController, animated: true)
                        
                    }
                }).disposed(by: disposeBag)
            
            
        }
        
    }
}
