//
//  UITestConstants.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 07/08/21.
//

import Foundation
class UITestConstants{
    
    
    enum Global: String{
        case alert = "PokemonUIAlertController"
    }
    
    enum HomeScreen: String{
        
        case listingTableView = "PokemonListingTableView"
        case searchField = "PokemonHomeSearchField"
        case listingCellNameLabel = "PokemonListingCellNameLabel"
        case listingCellIDLabel = "PokemonListingCellIDLabel"
        case listingCellTypesLabel = "PokemonListingCellTypesLabel"
        
    }
    
    enum DetailsScreen: String{
        case statsCollectionView = "PokemonStatsCollectionView"
        case abilitiesCollectionView = "PokemonAbilitiesCollectionView"
    }
    
}
