//
//  HomeUITestUtils.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 14/08/21.
//
@testable import Pokedex_Swift
import Foundation
import UIKit
import KIF

extension HomeUITests{
    
    func enterTextIntoCurrentFirstResponder(_ text: String) -> Void{
        tester().enterText(intoCurrentFirstResponder: text)
    }
    
    func getFirstCell() -> PokemonListingCell{
        return viewTester().waitForCellInTableView(at: IndexPath.init(row: 0, section: 0)) as! PokemonListingCell
    }
    
    
}
