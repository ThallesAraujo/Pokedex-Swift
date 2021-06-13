//
//  PokemonListingCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

class PokemonListingCell: UITableViewCell, ModeledCell {
    
    typealias modelType = Result
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var lblPokemonName: UILabel!
    
    var pokemon: Pokemon?{
        didSet{
            let imageUrl = pokemon?.sprites.other?.dreamWorld.frontDefault ?? pokemon?.sprites.frontDefault ?? ""
            self.pokemonImage.setImage(fromURL: imageUrl)
        }
    }
    
    let disposeBag = DisposeBag()
    
    static let identifier = "pokemonListingCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ model: Result) {
        self.lblPokemonName.text = model.name
        
        let pokemonFetched = HomeService.getPokemon(fromURL: model.url)
        
        pokemonFetched.subscribe(onNext: { value in
            self.pokemon = value
        }).disposed(by: disposeBag)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
