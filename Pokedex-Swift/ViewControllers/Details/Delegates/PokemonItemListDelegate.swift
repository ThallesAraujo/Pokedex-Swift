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
    
    func config(collectionView: UICollectionView, items: [Species]?, coordinator: Coordinator) {
        
        Observable.of(items ?? []).bind(to: collectionView.rx.items(cellIdentifier: PokemonItemCell.identifier, cellType: PokemonItemCell.self)) {_, model, cell in
            cell.lblItemName.text = model.name?.capitalized
        }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Species.self).subscribe(onNext: {model in
            coordinator.presentNextScreen(data: model)
//            actionType.didTapAction(item: model, navigation: navigation, disposeBag: weakself.disposeBag)
        }).disposed(by: disposeBag)
    }
}
