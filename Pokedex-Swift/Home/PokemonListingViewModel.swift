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
    
    lazy var searchData: Driver<[Result]> = {
        return self.searchText.asObservable()
            .flatMapLatest(PokemonListingViewModel.pokemonsFor)
            .asDriver(onErrorJustReturn: [])
    }()
    
    lazy var listData: Driver<[Result]> = {
        return PokemonListingViewModel.getPokemons().asDriver(onErrorJustReturn: [])
    }()
    
    
    static func pokemonsFor(_ idOrName: String) -> Observable<[Result]> {
        return HomeService.getPokemonResults(idOrName)
    }
    
    static func getPokemons() -> Observable<[Result]>{
        return HomeService.getPokemonsList()
    }
    
    
    
}
