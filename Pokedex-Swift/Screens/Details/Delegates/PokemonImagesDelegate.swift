//
//  PokemonImagesDelegate.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import RxDataSources

class PokemonImagesDelegate{
    
    var disposeBag = DisposeBag()
    
    func config(images: [String], collectionView: UICollectionView){
        Observable.of(images).bind(to: collectionView.rx.items(cellIdentifier: PokemonImageCell.identifier, cellType: PokemonImageCell.self)){index, model, cell in
            cell.imgPokemon.kf_setImage(url: model)
        }.disposed(by: disposeBag)
    }
    
}
