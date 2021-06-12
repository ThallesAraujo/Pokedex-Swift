//
//  PokemonListingViewModel.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import RxSwift
import RxCocoa

class PokemonListingViewModel{
    
    let searchText = BehaviorRelay<String>(value: "")
    
    
    lazy var data: Driver<[Pokemon]> = {
        return self.searchText.asObservable()
            .flatMapLatest(PokemonListingViewModel.pokemonsFor)
            .asDriver(onErrorJustReturn: [])
    }()
    
    static func pokemonsFor(_ idOrName: String) -> Observable<[Pokemon]> {
        return HomeService.getPokemonResults(idOrName)
    }
    
}
