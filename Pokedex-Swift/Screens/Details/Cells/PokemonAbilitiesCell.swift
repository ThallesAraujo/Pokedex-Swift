//
//  PokemonAbilitiesCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit

class PokemonAbilitiesCell: UITableViewCell, Storyboarded, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var abilitiesList: UICollectionView!
    
    var abilities: [AbilityDTO]?
    
    func config(abilities: [AbilityDTO]?){
        
        self.abilities = abilities
        abilitiesList.delegate = self
        abilitiesList.dataSource = self
        abilitiesList.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return abilities?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonAbilityCell.identifier, for: indexPath) as? PokemonAbilityCell{
            cell.lblAbilityName.text = abilities?[indexPath.row].ability?.name
            return cell
        }else{
            return PokemonAbilityCell()
        }
    }
    
}
