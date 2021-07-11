//
//  PokemonStatCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 27/06/21.
//

import Foundation
import UIKit
import RxSwift

class PokemonStatCell: UICollectionViewCell, Storyboarded{
    
    
    @IBOutlet weak var lblStatName: UILabel!
    @IBOutlet weak var lblStatValue: UILabel!
    @IBOutlet weak var statBar: UIProgressView!
    
    func config(statName: String, statValue: Int){
      
        self.lblStatName.text = statName.replacingOccurrences(of: "-", with: " ").capitalized
        self.lblStatValue.text = "\(statValue)"
        
        let progress = Observable.of(Float(Float(statValue)/510.000))
        
        progress.bind(to: self.statBar.rx.progress).disposed(by: DisposeBag())
    }
    
}
