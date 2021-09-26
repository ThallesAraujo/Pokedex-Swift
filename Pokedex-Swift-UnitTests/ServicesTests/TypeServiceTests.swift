//
//  TypeServiceTests.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 26/09/21.
//

import Foundation
@testable import Pokedex_Swift
import XCTest

//Tipo testado: fighting
let pokemonTypeURL = "https://pokeapi.co/api/v2/type/2/"
let firstPokemon = "mankey"
let secondPokemon = "poliwrath"

class TypeServiceTests: BaseTestCase{
    
    
    func testGetPokemonType(){
        getType(fromUrl: pokemonURL) { pokemonType in
            
             if let pokemons = pokemonType.pokemon{
                 let pokemonNames = pokemons.compactMap({$0.pokemon}).compactMap({$0.name})
                 
                 XCTAssertTrue(pokemonNames.contains(firstPokemon))
                 XCTAssertTrue(pokemonNames.contains(secondPokemon))
            }
            
            
            
        }
    }
    
}
