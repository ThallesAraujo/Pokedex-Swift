//
//  DetailsUITestUtils.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 29/08/21.
//

@testable import Pokedex_Swift
import Foundation
import KIF
import UIKit

extension DetailsUITests {
    
    /**
    Seleciona a primeira célula da lista, navega até a tela de detalhes e retorna a primeira célula de Stats
     */
    func selectAndGetFirstStat() -> PokemonStatCell {
        viewTester().tapRowInTableView(at: firstIndexPath)
        
        // swiftlint:disable:next line_length
        guard let cell = tester().waitForCell(at: firstIndexPath, inCollectionViewWithAccessibilityIdentifier: statsIdentifier) as? PokemonStatCell else {
            return PokemonStatCell()
        }
        
        return cell
        
    }
    
    /**
     Seleciona a primeira habilidade
     */
    func showFirstAbilityAlert(withExpectedLabel label: String) -> UIView {
        tester().waitForCell(at: firstIndexPath, inCollectionViewWithAccessibilityIdentifier: abilitiesIdentifier).tap()
        return tester().waitForView(withAccessibilityLabel: label)
    }
    
    /**
     Dispensa o modal de abilidade
     */
    func dismissAbilityAlert() {
        tester().waitForView(withAccessibilityLabel: "Ok").tap()
    }
    
}
