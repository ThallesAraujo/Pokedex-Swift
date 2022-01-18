//
//  HomeViewController+MacCatalystExtension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 18/01/22.
//

import Foundation
import UIKit

extension HomeViewController{
    
    func configureMacCatalyst() {
        #if targetEnvironment(macCatalyst)
            self.view.backgroundColor = .clear
            self.pokemonListingTableView.backgroundColor = .clear
        #endif
    }
    
}
