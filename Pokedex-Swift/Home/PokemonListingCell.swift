//
//  PokemonListingCell.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit
import Foundation

class PokemonListingCell: UITableViewCell, ModeledCell {
    
    typealias modelType = Pokemon
    

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var lblPokemonName: UILabel!
    
    static let identifier = "pokemonListingCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ model: Pokemon) {
        self.lblPokemonName.text = model.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
