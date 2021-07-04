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

class PokemonItemListDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var itemsList: UICollectionView?{
        didSet{
            self.itemsList?.delegate = self
            self.itemsList?.dataSource = self
        }
    }
    
    var items: [Species]?
    
    let disposeBag = DisposeBag()
    var didTapClosure:((IndexPath) -> Void)?
    
    
    func config(items: [Species]?, didTapClosure: ((IndexPath) -> Void)? = nil){
        self.items = items
        self.didTapClosure = didTapClosure
        itemsList?.reloadData()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonItemCell.identifier, for: indexPath) as? PokemonItemCell{
            cell.lblItemName.text = items?[indexPath.item].name?.capitalized
            return cell
        }else{
            return PokemonItemCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let didTap = didTapClosure{
            didTap(indexPath)
        }
    }
}
