//
//  EvolutionsViewModel.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 27/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class EvolutionsViewModel{
    
    var evolution: BehaviorRelay<Evolution?> = BehaviorRelay.init(value: nil)
    
    var errorHasOccurred: BehaviorRelay<Bool> = BehaviorRelay<Bool>.init(value: false)
    
    let disposeBag = DisposeBag()
    
    func getEvolutions(id: Int){
        DetailsService.getPokemonEvolution(id, errorBinder: errorHasOccurred).subscribe(onNext: {evolution in
            self.evolution.accept(evolution)
        }).disposed(by: disposeBag)
    }
    
}
