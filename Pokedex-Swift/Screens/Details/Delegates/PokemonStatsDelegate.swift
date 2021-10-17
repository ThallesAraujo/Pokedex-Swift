//
//  PokemonStatsDelegate.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit
import RxSwift

class PokemonStatsDelegate {
    
    var disposeBag = DisposeBag()
    
    func config(collectionView: UICollectionView, stats: [Stat]?) {
        Observable.of(stats ?? []).bind(to: collectionView.rx.items(cellIdentifier: PokemonStatCell.identifier, cellType: PokemonStatCell.self)) {_, model, cell in
            cell.config(statName: model.stat?.name ?? "", statValue: model.baseStat ?? 0)
        }.disposed(by: disposeBag)
    }
    
}
