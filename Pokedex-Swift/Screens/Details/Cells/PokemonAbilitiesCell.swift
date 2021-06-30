//
//  PokemonAbilitiesCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class PokemonAbilitiesCell: UITableViewCell, Storyboarded, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var abilitiesList: UICollectionView!
    
    var abilities: [AbilityDTO]?
    
    let disposeBag = DisposeBag()
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let ability = self.abilities?[indexPath.row], let abilityUrl = ability.ability?.url {
            let details = DetailsService.getAbility(fromURL: abilityUrl)
            let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            
            details.subscribe(onNext: {detail in
                let abilityName = ability.ability?.name ?? ""
                
                let message = detail.flavorTextEntries?.first(where: {$0.language?.name == "en"})?.flavorText ?? ""
                
                if !abilityName.isEmpty && !message.isEmpty{
                    keyWindow?.rootViewController?.showAlert(title: abilityName.capitalized, message: message)
                }
                
            }).disposed(by: disposeBag)
            
        }
    }
}
