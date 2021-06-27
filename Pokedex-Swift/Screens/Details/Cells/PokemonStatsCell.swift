//
//  PokemonStatsCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit

class PokemonStatsCell: UITableViewCell, Storyboarded, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var lblStats: UILabel!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    
    var stats: [Stat]?
    
    func config(stats: [Stat]?){
        self.stats = stats
        self.statsCollectionView.delegate = self
        self.statsCollectionView.dataSource = self
        self.statsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonStatCell.identifier, for: indexPath) as? PokemonStatCell{
            
            guard let stat = stats?[indexPath.row], let statValue = stat.baseStat else{
                return cell
            }
            
            cell.config(statName: stat.stat?.name ?? "",statValue: statValue)
            return cell
        }else{
            return PokemonStatCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 133, height: 152)
    }
    
    
    
}
