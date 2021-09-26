//
//  DetailsServiceTestsUtils.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 19/09/21.
//

import Foundation
@testable import Pokedex_Swift
import XCTest
import RxSwift
import RxCocoa

extension DetailsServiceTests{
    
    func getAbility(fromUrl url: String, andAssert assertion: @escaping (Ability) -> Void){
        
        let abilityObservable = DetailsService.getAbility(fromURL: url)
        
        abilityObservable.subscribe(onNext: {[weak self] ability in
            assertion(ability)
            guard let weakself = self else {return}
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func getEvolutions(ofPokemon id: Int, andAssert assertion: @escaping (Evolution?) -> Void){
        
        let evolutionsObservable = DetailsService.getPokemonEvolution(id, errorBinder: errorBinder)
        
        evolutionsObservable.subscribe(onNext: {[weak self] evolutions in
            assertion(evolutions)
            guard let weakself = self else { return }
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
        complete()
        
    }
    
    
}
