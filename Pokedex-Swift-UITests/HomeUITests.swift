//
//  HomeUITests.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 08/08/21.
//
// IMPORTANTE: adicionar o KIF a um target de testes unitários, não de testes de UI!


///Classe de testes de interface da tela inicial (Home)
import Foundation
import KIF
import Nimble

class HomeUITests: KIFTestCase{
    
    let searchFieldIdentifier = UITestConstants.HomeScreen.searchField.rawValue
    let listingTableViewIdentifier = UITestConstants.HomeScreen.listingTableView.rawValue
    
    
    override func beforeEach() {
        tester().waitForView(withAccessibilityLabel: searchFieldIdentifier)
        tester().tapView(withAccessibilityLabel: searchFieldIdentifier)
        tester().clearTextFromFirstResponder()
    }
    
    ///Testa se o nome do pokémon pesquisado por ID corresponde ao resultado esperado
    ///Pokémon utilizado nesse teste: Noctowl [https://pokeapi.co/api/v2/pokemon/164]
    func testPokemonSearchName(){
        enterTextIntoCurrentFirstResponder("164")
        let pokemonName = getPropertyFromFirstCell(named: "text", atIndex: 0)
        expect(pokemonName == "Noctowl") == true
    }
    
    /// Testa se o ID do pokemon pesquisado por nome corresponde ao resultado esperado
    /// Pokémon utilizado nesse teste: Pikachu [https://pokeapi.co/api/v2/pokemon/pikachu]
    func testPokemonSearchID(){
        enterTextIntoCurrentFirstResponder("pikachu")
        let pokemonID = getPropertyFromFirstCell(named: "text", atIndex: 2)
        expect(pokemonID == "25") == true
    }
    
    ///Testa se os tipos do pokémon pesquisado correspondem ao resultado esperado
    /// Pokémon utilizado nesse teste: Xatu [https://pokeapi.co/api/v2/pokemon/178]
    func testPokemonSearchTypes(){
        enterTextIntoCurrentFirstResponder("178")
        let pokemonTypes = getPropertyFromFirstCell(named: "text", atIndex: 1)
        expect(pokemonTypes?.contains("psychic") ?? false) == true
        expect(pokemonTypes?.contains("flying") ?? false) == true
    }
    
}
