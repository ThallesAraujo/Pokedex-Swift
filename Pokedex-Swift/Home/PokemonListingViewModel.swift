//
//  PokemonListingViewModel.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import RxSwift
import RxCocoa

class PokemonListingViewModel{
    
    let searchText = BehaviorRelay<String?>(value: "")
    
    var searchData: BehaviorRelay<[Result]> = BehaviorRelay<[Result]>.init(value: [])
    
    var limit = 20
    var offset = 20
    
    var disposeBag = DisposeBag()
    
    var listData: BehaviorRelay<[Result]> = BehaviorRelay<[Result]>.init(value: [])
    
    var errorHasOccurred: BehaviorRelay<Bool> = BehaviorRelay<Bool>.init(value: false)
    
    func getPokemonsResults(_ idOrName: String){
        HomeService.getPokemonResults(idOrName, errorBinder: self.errorHasOccurred).subscribe(onNext:{results in
            self.searchData.accept(results)
        }).disposed(by: disposeBag)
    }
    
    func getNextPage() -> Observable<[Result]> {
        return HomeService.getNextPage(offset: offset, limit: limit, errorBinder: self.errorHasOccurred)
    }
    
    func getPokemonsList(){
        HomeService.getPokemonsList(errorBinder: self.errorHasOccurred).subscribe(onNext: {list in
            self.listData.accept(list)
        }).disposed(by: disposeBag)
    }
    
    
    
}
