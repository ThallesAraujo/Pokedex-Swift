//
//  HomeTestingExtensions.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 07/08/21.
//

import Foundation
extension HomeViewController{
    
    func setupUITestIdentifiers(){
        self.pokemonListingTableView.accessibilityIdentifier = UITestConstants.HomeScreen.listingTableView.rawValue
        self.pokemonListingTableView.isAccessibilityElement = true
        
        self.searchBar.accessibilityLabel = UITestConstants.HomeScreen.searchField.rawValue
        self.searchBar.accessibilityIdentifier = UITestConstants.HomeScreen.searchField.rawValue
        self.searchBar.isAccessibilityElement = true
    }
    
}
