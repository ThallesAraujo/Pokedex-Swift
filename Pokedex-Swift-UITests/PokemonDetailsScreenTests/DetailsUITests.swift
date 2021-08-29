//
//  DetailsUITests.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 14/08/21.
//
@testable import Pokedex_Swift
import Foundation
import KIF
import Nimble

class DetailsUITests: KIFTestCase{
    
    let abilitiesIdentifier = UITestConstants.DetailsScreen.abilitiesCollectionView.rawValue
    let statsIdentifier = UITestConstants.DetailsScreen.statsCollectionView.rawValue
    let alertIdentifier = UITestConstants.Global.alert.rawValue
    
    let firstIndexPath = IndexPath.init(row: 0, section: 0)

    override func beforeEach() {
        popToRootViewController()
        turnSearchBarIntoFirstResponder()
    }
    
    /**
        Testa se o primeiro Pokémon listado possui stats e abilities corretos
        Pokemon testado: Bulbasaur [https://pokeapi.co/api/v2/pokemon/1]
        Habilidade testada: https://pokeapi.co/api/v2/ability/65/
     */
    func testFirstPokemon(){
        
        let cell = selectAndGetFirstStat()
        expect(cell.lblStatValue.text!).to(equal("45"))
        let abilityAlert = showFirstAbilityAlert(withExpectedLabel: "Ups GRASS moves in a pinch.")
        expect(abilityAlert).toNot(beNil())
        dismissAbilityAlert()
        
    }
    
    /**
        Testa se ao pesquisar por um Pokémon, o resultado encontrado possui os stats e abilities corretos
        Pokemon testado: Dragonite [https://pokeapi.co/api/v2/pokemon/dragonite]
        Habilidade testada: https://pokeapi.co/api/v2/ability/39/
     */
    func testResearchedPokemon(){
        
        enterTextIntoCurrentFirstResponder("dragonite")
        let cell = selectAndGetFirstStat()
        expect(cell.lblStatValue.text!).to(equal("91"))
        let abilityAlert = showFirstAbilityAlert(withExpectedLabel: "Prevents flinching.")
        expect(abilityAlert).toNot(beNil())
        dismissAbilityAlert()
        
    }
    
    
    
}

