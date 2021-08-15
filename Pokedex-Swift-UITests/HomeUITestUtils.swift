//
//  HomeUITestUtils.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 14/08/21.
//

import Foundation
import UIKit
import KIF

extension HomeUITests{
    
    func enterTextIntoCurrentFirstResponder(_ text: String) -> Void{
        tester().enterText(intoCurrentFirstResponder: text)
    }
    
    func getFirstCell() -> UITableViewCell?{
        return tester().waitForCell(at: IndexPath.init(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: listingTableViewIdentifier)
    }
    
    func getPropertyFromFirstCell(named key: String, atIndex index: Int) -> String?{
        let pokemonCell = getFirstCell()
        return PropertyGetter.getValueFrom(pokemonCell?.accessibilityElement(at: index), forKey: key)
    }
    
    
}
