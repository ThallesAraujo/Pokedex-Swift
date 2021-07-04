//
//  TypePokemonsViewModel.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 03/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class TypePokemonsViewModel{
    
    var pokemonSpecies: BehaviorRelay<[Species?]> = BehaviorRelay<[Species?]>.init(value: [])
    var pokemonType: Species?
    
    var disposeBag = DisposeBag()
    
    func getType() {
        TypeService.getType(fromURL: pokemonType?.url ?? "").subscribe(onNext: {pokemonType in
            self.pokemonSpecies.accept(pokemonType.pokemon?.compactMap({Species.init(name: $0.pokemon?.name ?? "", url: $0.pokemon?.url ?? "")}) ?? [])
        }).disposed(by: disposeBag)
        
    }
    
}
