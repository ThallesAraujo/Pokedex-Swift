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


// Casos de Teste:
// - Tocar no primeiro pokemon (Home), verificar detalhes (Stats)
// - Pesquisar por um pokemon, verificar detalhes (Stats)
// - Tocar no segundo pokemon (Home), verificar descrição de habilidade

// Por hora, esse caso de teste deve ser executado com o HomeUITests desabilitado

class DetailsUITests: KIFTestCase{
    
    let abilitiesIdentifier = UITestConstants.DetailsScreen.abilitiesCollectionView.rawValue
    let statsIdentifier = UITestConstants.DetailsScreen.statsCollectionView.rawValue
    let alertIdentifier = UITestConstants.Global.alert.rawValue

    func testFirstPokemon(){
        viewTester().tapRowInTableView(at: IndexPath.init(row: 0, section: 0))
        let cell = tester().waitForCell(at: IndexPath.init(row: 0, section: 0), inCollectionViewWithAccessibilityIdentifier: statsIdentifier) as! PokemonStatCell
        
        expect(cell.lblStatValue.text!).to(equal("45"))
        
        tester().waitForCell(at: IndexPath.init(row: 0, section: 0), inCollectionViewWithAccessibilityIdentifier: abilitiesIdentifier).tap()
        
        let abilityAlert = tester().waitForView(withAccessibilityLabel: "Ups GRASS moves in a pinch.")
        
        expect(abilityAlert).toNot(beNil())
        
        tester().waitForView(withAccessibilityLabel: "Ok").tap()
    }
    
    
    
}

