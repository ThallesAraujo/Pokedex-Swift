//
//  HomeServiceTests.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 05/09/21.
//

@testable import Pokedex_Swift

import Foundation
import XCTest
import RxSwift
import RxCocoa

let pokemonURL = "https://pokeapi.co/api/v2/pokemon/41"
let urlToFail =  "https://pokeapi.co/api/v2/pokemon/982"

class HomeServiceTests: BaseTestCase {
    
    func testListNotEmpty() {
        getListAndAssert { pokemons in
            XCTAssertTrue(pokemons.count > 0)
        }
    }
    
    func testIfPokemonIsPresent() {
        
        getListAndAssert { pokemons in
            XCTAssertTrue(pokemons.filter({$0.name == "bulbasaur"}).count > 0)
        }
        
    }
    
    func testPokemonDetails() {
        
        getPokemonAndAssert(url: pokemonURL) { pokemon in
            XCTAssertTrue(pokemon.name == "zubat")
            
            if let pokemonTypes = pokemon.types?.compactMap({$0.type?.name}) {
                let expectedTypes = Set(["poison", "flying"])
                let ordenatedPokemonTypes = Set(pokemonTypes)
                XCTAssertTrue(expectedTypes.isSubset(of: ordenatedPokemonTypes))
            }
           
        }
    }
    
    func testPokemonResults() {
        getPokemonResultsAndAssert(idOrName: "25") { results in
            XCTAssertTrue(results.count == 1)
            XCTAssertTrue(results[0].name == "pikachu")
        }
    }
    
    func testIfListIsEmpty() {
        getPokemonResultsAndAssert(idOrName: "Nehallennia") { results in
            XCTAssert(results.count == 0)
        }
    }
    
    func testUrlFailure() {
        
        expectation.isInverted = true
        
        getPokemonAndAssert(url: urlToFail) { pokemon in
            XCTAssertNil(pokemon)
        }
    }
    
    func testGetPage() {
        getPageAndAssert(offset: 21) { page in
            XCTAssertTrue(page.count > 0)
        }
    }
    
    func testIfPageDoesntExist() {
        
        getPageAndAssert(offset: 1432) { page in
            XCTAssertTrue(page.count == 0)
        }
    }
    
}
