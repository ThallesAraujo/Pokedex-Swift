//
//  PokemonImagesDelegate.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit
import Kingfisher

class PokemonImagesDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var imagesCollectionView: UICollectionView?{
        didSet{
            self.imagesCollectionView?.delegate = self
            self.imagesCollectionView?.dataSource = self
        }
    }
    
    var images: [String?] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonImageCell.identifier, for: indexPath) as? PokemonImageCell{
            
            if let imageUrl = images[indexPath.row]{
                cell.imgPokemon.kf_setImage(url: imageUrl)
            }
            return cell
        }else{
          return PokemonImageCell()
        }
    }
    
    func reloadData(){
        self.imagesCollectionView?.reloadData()
    }
    
}
