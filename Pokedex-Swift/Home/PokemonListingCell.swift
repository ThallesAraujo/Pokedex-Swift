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
import UIImageColors

class PokemonListingCell: UITableViewCell, ModeledCell {
    
    typealias modelType = Result
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTypes: UILabel!
    @IBOutlet weak var lblID: UILabel!
    
    var pokemon: Pokemon?{
        didSet{
            let imageUrl = pokemon?.sprites.other?.dreamWorld.frontDefault ?? pokemon?.sprites.frontDefault ?? ""
            self.pokemonImage.setImage(fromURL: imageUrl)
            self.endConfig()
        }
    }
    
    let disposeBag = DisposeBag()
    
    static let identifier = "pokemonListingCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func endConfig(){
        self.lblID.text = "\(self.pokemon?.id ?? 0)"
        
    
        
        self.lblTypes.text = "\(self.pokemon?.types.map({ $0.type.name}).joined(separator: ", ") ?? "")"
    }
    
    func config(_ model: Result) {
        self.lblPokemonName.text = model.name
        
        let pokemonFetched = HomeService.getPokemon(fromURL: model.url)
        
        pokemonFetched.subscribe(onNext: { value in
            self.pokemon = value
            print("Espécie: \(value.types[0].type.name)")
        }).disposed(by: disposeBag)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func tintWithDominantColor (){
        let imageUrl = pokemon?.sprites.frontDefault ?? ""
        let imageViewTemp = UIImageView.init()
        imageViewTemp.getDominantColor(fromURL: imageUrl, toTintView: self.cardView)
    }

}
