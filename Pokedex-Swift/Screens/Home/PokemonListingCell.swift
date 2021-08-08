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

class PokemonListingCell: UITableViewCell, Storyboarded {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTypes: UILabel!
    @IBOutlet weak var lblID: UILabel!
    
    var pokemon: Pokemon?
    
    let disposeBag = DisposeBag()
    
    private func endConfig(){
        self.lblID.text = "\(self.pokemon?.id ?? 0)"
        self.lblTypes.text = "\(self.pokemon?.types?.map({ $0.type?.name ?? ""}).joined(separator: ", ") ?? "")"
    }
    
    func config(_ model: Result?) {
        self.configureTesting()
        self.lblPokemonName.text = model?.name.capitalized
        
        let pokemonFetched = HomeService.getPokemon(fromURL: model?.url ?? "")
        
        let dispatcher = DispatchGroup()
        dispatcher.enter()
        pokemonFetched.observe(on: ConcurrentDispatchQueueScheduler(qos: .background)).subscribe(onNext: { value in
            self.pokemon = value
            dispatcher.leave()
        }).disposed(by: disposeBag)
        
        dispatcher.notify(queue: .main, execute: {
            let imageUrl = self.pokemon?.sprites?.other?.dreamWorld?.frontDefault ?? self.pokemon?.sprites?.frontDefault ?? ""
            self.pokemonImage.setImage(fromURL: imageUrl)
            self.endConfig()
        })
        
        
    }
    
    private func tintWithDominantColor (){
        let imageUrl = pokemon?.sprites?.frontDefault ?? ""
        let imageViewTemp = UIImageView.init()
        imageViewTemp.getDominantColor(fromURL: imageUrl, toTintView: self.cardView)
    }
    
    private func configureTesting(){
        self.lblID.setTestingIdentifier(UITestConstants.HomeScreen.listingCellIDLabel.rawValue)
        self.lblTypes.setTestingIdentifier(UITestConstants.HomeScreen.listingCellTypesLabel.rawValue)
        self.lblPokemonName.setTestingIdentifier(UITestConstants.HomeScreen.listingCellNameLabel.rawValue)
    }

}
