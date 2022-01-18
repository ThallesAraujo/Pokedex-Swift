//
//  PokemonAbilityCoordinator.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 21/11/21.
//

import Foundation
import UIKit
import RxSwift

class PokemonAbilityCoordinator: Coordinator {
    
    var navigation: Navigation?
    
    var disposeBag = DisposeBag()
    
    let service = DetailsService()
    
    required init(navigation: Navigation?) {
        self.navigation = navigation
    }
    
    func presentNextScreen(data: Any?) {
        if let item = data as? Species {
            
            let details = service.getAbility(fromURL: item.url ?? "")
            let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
                
                details.subscribe(onNext: {detail in
                    let abilityName = item.name?.capitalized ?? ""
                    let message = detail.flavorTextEntries?.first(where: {$0.language?.name == Constants.defaultLanguage})?.flavorText ?? ""
                    
                    if !abilityName.isEmpty && !message.isEmpty {
                        keyWindow?.rootViewController?.showAlert(title: abilityName.capitalized, message: message)
                    }
                    
                }).disposed(by: disposeBag)
            
        }
    }
      
}
