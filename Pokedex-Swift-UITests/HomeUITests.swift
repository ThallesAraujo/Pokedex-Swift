//
//  HomeUITests.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 08/08/21.
//
// IMPORTANTE: adicionar o KIF a um target de testes unitários, não de testes de UI!


///Classe de testes de interface da tela inicial (Home)
import Foundation
class HomeUITests: KIFTestCase{
    
    let searchFieldIdentifier = UITestConstants.HomeScreen.searchField.rawValue
    let listingTableViewIdentifier = UITestConstants.HomeScreen.listingTableView.rawValue
    
    ///Testa se o nome do pokémon pesquisado por ID corresponde ao resultado esperado
    ///Pokémon utilizado nesse teste: Noctowl [https://pokeapi.co/api/v2/pokemon/164]
    func testPokemonSearchName(){
        
        tester().waitForView(withAccessibilityLabel: searchFieldIdentifier)
        tester().tapView(withAccessibilityLabel: searchFieldIdentifier)
        tester().clearTextFromFirstResponder()
        tester().enterText(intoCurrentFirstResponder: "164")
       
        let pokemonCell = tester().waitForCell(at: IndexPath.init(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: listingTableViewIdentifier)
        
        let pokemonName = PropertyGetter.getValueFrom(pokemonCell?.accessibilityElement(at:0), forKey: "text")
        
        assert(pokemonName == "Noctowl")
        
    }
    
    /// Testa se o ID do pokemon pesquisado por nome corresponde ao resultado esperado
    /// Pokémon utilizado nesse teste: Pikachu [https://pokeapi.co/api/v2/pokemon/pikachu]
    func testPokemonSearchID(){
        
        tester().waitForView(withAccessibilityLabel: searchFieldIdentifier)
        tester().tapView(withAccessibilityLabel: searchFieldIdentifier)
        tester().clearTextFromFirstResponder()
        tester().enterText(intoCurrentFirstResponder: "pikachu")
       
        let pokemonCell = tester().waitForCell(at: IndexPath.init(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: listingTableViewIdentifier)
        
        let pokemonID = PropertyGetter.getValueFrom(pokemonCell?.accessibilityElement(at:2), forKey: "text")
        
        assert(pokemonID == "25")
    }
    
    ///Testa se os tipos do pokémon pesquisado correspondem ao resultado esperado
    /// Pokémon utilizado nesse teste: Xatu [https://pokeapi.co/api/v2/pokemon/178]
    func testPokemonSearchTypes(){
        
        tester().waitForView(withAccessibilityLabel: searchFieldIdentifier)
        tester().tapView(withAccessibilityLabel: searchFieldIdentifier)
        tester().clearTextFromFirstResponder()
        tester().enterText(intoCurrentFirstResponder: "178")
       
        let pokemonCell = tester().waitForCell(at: IndexPath.init(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: listingTableViewIdentifier)
        
        let pokemonTypes = PropertyGetter.getValueFrom(pokemonCell?.accessibilityElement(at:1), forKey: "text")
        
        assert(pokemonTypes?.contains("psychic") ?? false)
        assert(pokemonTypes?.contains("flying") ?? false)
    }
    
    
    
//    func testTapPokemon(){
//
//        sleep(10)
//
//        tester().tapRow(at: IndexPath.init(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UITestConstants.HomeScreen.listingTableView.rawValue)
//
//        //XCAssert...
//
//    }
    
}
