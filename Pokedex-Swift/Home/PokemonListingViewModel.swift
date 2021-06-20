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
    
    init() {
        self.observeError()
    }
    
    func bindSearchText(configureClosure: @escaping() -> Void){
        self.searchText.distinctUntilChanged().asDriver(onErrorJustReturn: "").drive(onNext: ({terms in
            guard let terms = terms, !terms.isEmpty else{
                self.searchData.accept([])
                return
            }
            self.getPokemonsResults(terms)
            configureClosure()
        })).disposed(by: disposeBag)
    }
    
    
    func observeError(){
        self.errorHasOccurred.subscribe(onNext:{hasError in
            if hasError{
                self.listData.accept([])
                self.searchData.accept([])
            }
        }).disposed(by: disposeBag)
    }
    
    func getPokemonsResults(_ idOrName: String){
        HomeService.getPokemonResults(idOrName, errorBinder: self.errorHasOccurred).subscribe(onNext:{results in
            self.searchData.accept(results)
        }).disposed(by: disposeBag)
    }
    
    func getNextPage() {
        HomeService.getNextPage(offset: offset, limit: limit, errorBinder: self.errorHasOccurred).subscribe(onNext:{nextResults in
                var appended = self.listData.value
                let appendedSet = Set(appended)
                let nextSet = Set(nextResults)
                
                if !nextSet.isSubset(of: appendedSet){
                    appended.append(contentsOf: nextResults)
                    self.listData.accept(appended)
                    self.offset = self.offset + 20
                }
        }).disposed(by: disposeBag)
    }
    
    func getPokemonsList(){
        HomeService.getPokemonsList(errorBinder: self.errorHasOccurred).subscribe(onNext: {list in
            self.listData.accept(list)
        }).disposed(by: disposeBag)
    }
    
    
    
}
