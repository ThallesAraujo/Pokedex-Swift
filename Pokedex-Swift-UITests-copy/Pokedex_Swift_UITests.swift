//
//  Pokedex_Swift_UITests.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 07/08/21.
//

/// IMPORTANTE: adicionar o KIF a um target de testes unitários, não de testes de UI!

import XCTest
import UIKit

class Pokedex_Swift_UITests: KIFTestCase {

    func testTapPokemon(){
        
        sleep(10)
        
        tester().tapRow(at: IndexPath.init(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UITestConstants.HomeScreen.listingTableView.rawValue)
        
        //XCAssert...
        
    }
   
}
