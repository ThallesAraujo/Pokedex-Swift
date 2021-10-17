//
//  PokemonItemListDelegate.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class PokemonItemListDelegate {
    
    let disposeBag = DisposeBag()
    
    func config(collectionView: UICollectionView, items: [Species]?, actionType: ActionType, navigation: UINavigationController?) {
        
        Observable.of(items ?? []).bind(to: collectionView.rx.items(cellIdentifier: PokemonItemCell.identifier, cellType: PokemonItemCell.self)) {_, model, cell in
            cell.lblItemName.text = model.name?.capitalized
        }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Species.self).subscribe(onNext: {[weak self] model in
            guard let weakself = self else {return}
            actionType.didTapAction(item: model, navigation: navigation, disposeBag: weakself.disposeBag)
        }).disposed(by: disposeBag)
    }
}
