//
//  DetailsServiceTests.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 19/09/21.
//

import Foundation
@testable import Pokedex_Swift
import XCTest
import RxSwift

// MARK: - Ability Constants

let abilityUrl = "https://pokeapi.co/api/v2/ability/4/"
let expectedAbilityName = "battle-armor"
let pokemonExpectedToHaveAbility = "cubone"
let expectedAbilityDescription = "Blocks critical hits."
let defaultLanguage = "en"

// MARK: - Evolutions Constants

// Pokémon: Blastoise
let pokemonId = 9
let noValidEvolutions = "Não foi encontrada nenhuma evolução"

class DetailsServiceTests: BaseTestCase {
    
    func testGetAbility() {
        
        getAbility(fromUrl: abilityUrl) { ability in
            
            let abilityDescription = ability.flavorTextEntries?.first(where: {$0.language?.name == defaultLanguage})?.flavorText
            
            XCTAssertTrue(abilityDescription == expectedAbilityDescription)
            XCTAssertTrue(ability.name == expectedAbilityName)
            XCTAssertTrue(ability.pokemon?.filter({$0.pokemon?.name == pokemonExpectedToHaveAbility}).count ?? 0 > 0)
            
        }
    }
    
    func testGetEvolution() {
        
        getEvolutions(ofPokemon: pokemonId) { evolutions in
            guard let evs = evolutions else {
                XCTFail(noValidEvolutions)
                return
            }
            
            XCTAssertTrue(evs.chain?.species?.name == "ekans")
        }
        
    }
    
}
