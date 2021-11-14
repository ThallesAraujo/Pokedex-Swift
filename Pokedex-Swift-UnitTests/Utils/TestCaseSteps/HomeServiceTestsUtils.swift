//
//  HomeServiceTestsUtils.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 05/09/21.
//

import Foundation
@testable import Pokedex_Swift

import XCTest
import RxSwift
import RxCocoa

extension HomeServiceTests {
    
    func getListAndAssert(assertion: @escaping ([Result]) -> Void) {
        
        let pokemonsObservable = HomeService.getPokemonsList(errorBinder: errorBinder)
        
        pokemonsObservable.subscribe(onNext: {[weak self] pokemons in
            assertion(pokemons)
            guard let weakself = self else {return}
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
       complete()
    }
    
    func getPokemonAndAssert(url: String, assertions: @escaping (Pokemon) -> Void) {
        
        let pokemonObservable = HomeService.getPokemon(fromURL: url)
        
        pokemonObservable.subscribe(onNext: {[weak self] pokemon in
            assertions(pokemon)
            guard let weakself = self else {return}
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
        complete()
    }
    
    func getPokemonResultsAndAssert(idOrName: String, assertions: @escaping ([Result]) -> Void) {
        
        let pokemonObservable = HomeService.getPokemonResults(idOrName, errorBinder: errorBinder)
        
        pokemonObservable.subscribe(onNext: {[weak self] pokemons in
            assertions(pokemons)
            guard let weakself = self else {return}
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
        complete()
    }
    
    func getPageAndAssert(offset: Int, assertions: @escaping ([Result]) -> Void) {
        
        let pageObservable = HomeService.getNextPage(offset: offset, limit: 20, errorBinder: errorBinder)
        
        pageObservable.subscribe(onNext: {[weak self] page in
            assertions(page)
            guard let weakself = self else {return}
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
        complete()
    }
    
}
