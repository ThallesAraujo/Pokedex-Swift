//
//  DetailsTestExtensions.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 15/08/21.
//

import Foundation
import UIKit

extension PokemonDetailsViewController: UITestableViewController{
    func setupUITestIdentifiers() {
        self.pokemonStatsCollectionView.isAccessibilityElement = true
        self.pokemonStatsCollectionView.accessibilityIdentifier = UITestConstants.DetailsScreen.statsCollectionView.rawValue
        
        
        self.pokemonAbilitiesCollectionView.isAccessibilityElement = true
        self.pokemonAbilitiesCollectionView.accessibilityIdentifier = UITestConstants.DetailsScreen.abilitiesCollectionView.rawValue
    }
    
    
}
