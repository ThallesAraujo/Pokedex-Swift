//
//  HomeUITests.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 08/08/21.
//
// IMPORTANTE: adicionar o KIF a um target de testes unitários, não de testes de UI!


///Classe de testes de interface da tela inicial (Home)
@testable import Pokedex_Swift
import Foundation
import KIF
import Nimble

class HomeUITests: KIFTestCase{
    
    let searchFieldIdentifier = UITestConstants.HomeScreen.searchField.rawValue
    
    override func beforeEach() {
        popToRootViewController()
        turnSearchBarIntoFirstResponder()
        tester().waitForView(withAccessibilityLabel: searchFieldIdentifier)
        tester().tapView(withAccessibilityLabel: searchFieldIdentifier)
        tester().clearTextFromFirstResponder()
    }
    
    ///Testa se o nome do pokémon pesquisado por ID corresponde ao resultado esperado
    ///Pokémon utilizado nesse teste: Noctowl [https://pokeapi.co/api/v2/pokemon/164]
    
    func testPokemonSearchName(){
        enterTextIntoCurrentFirstResponder("164")
        let pokemonName = getFirstCell().lblPokemonName.text!
        expect(pokemonName).to(equal("Noctowl"))
    }
    
    /// Testa se o ID do pokemon pesquisado por nome corresponde ao resultado esperado
    /// Pokémon utilizado nesse teste: Pikachu [https://pokeapi.co/api/v2/pokemon/pikachu]
    
    func testPokemonSearchID(){
        enterTextIntoCurrentFirstResponder("pikachu")
        let pokemonID = getFirstCell().lblID.text!
        expect(pokemonID).to(equal("25"))
    }
    
    ///Testa se os tipos do pokémon pesquisado correspondem ao resultado esperado
    /// Pokémon utilizado nesse teste: Xatu [https://pokeapi.co/api/v2/pokemon/178]
    
    func testPokemonSearchTypes(){
        enterTextIntoCurrentFirstResponder("178")
        viewTester().wait(forTimeInterval: TimeInterval.init(5.0))
        let pokemonTypes = getFirstCell().lblTypes.text!
        expect(pokemonTypes).to(contain("psychic", "flying"))
    }
    
}
