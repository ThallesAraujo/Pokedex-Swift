//
//  PokemonAbilitiesCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit

class PokemonFormsCell: UITableViewCell, Storyboarded, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var formsList: UICollectionView!
    
    var forms: [Species]?
    
    func config(forms: [Species]?){
        
        self.forms = forms
        formsList.delegate = self
        formsList.dataSource = self
        formsList.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forms?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonAbilityCell.identifier, for: indexPath) as? PokemonAbilityCell{
            cell.lblAbilityName.text = forms?[indexPath.row].name
            return cell
        }else{
            return PokemonAbilityCell()
        }
    }
    
}

