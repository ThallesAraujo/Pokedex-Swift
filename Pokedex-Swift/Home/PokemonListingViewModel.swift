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
    
    var limit = 20
    var offset = 20
    
    var disposeBag = DisposeBag()
    
    var listData: BehaviorRelay<[Result]> = BehaviorRelay<[Result]>.init(value: [])
    
    func getNextPage() -> Observable<[Result]> {
        return HomeService.getNextPage(offset: offset, limit: limit)
    }
    
    static func pokemonsFor(_ idOrName: String) -> Observable<[Result]> {
        return HomeService.getPokemonResults(idOrName)
    }
    
    func getPokemonsList(){
        HomeService.getPokemonsList().subscribe(onNext: {list in
            self.listData.accept(list)
        }).disposed(by: disposeBag)
    }
    
    
    
}
