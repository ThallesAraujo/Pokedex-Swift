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
    
    var pokemonImage = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))
    var lblPokemonName = UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 45))
    var lblTypes = UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 45))
    var lblID = UILabel()
    
    var pokemon: Pokemon?
    
    let disposeBag = DisposeBag()
    
    let service = HomeService()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lblID.textAlignment = .right
        lblID.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblID)
        lblID.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        lblID.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        lblID.font = UIFont.init(name: "Quicksand-Bold", size: 36)
        lblID.textColor = UIColor.init(named: "SecondaryTitleColor")
        
        self.backgroundColor = UIColor.init(named: "SecondaryBackgroundColor")
        
        let detailsStack = UIStackView.init(arrangedSubviews: [lblPokemonName, lblTypes])
        detailsStack.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        detailsStack.axis = .vertical
        detailsStack.alignment = .leading
        detailsStack.spacing = 10
        
        let horizontalStack = UIStackView.init(arrangedSubviews: [pokemonImage, detailsStack])
        horizontalStack.frame = self.frame.insetBy(dx: 8, dy: 8)
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .leading
        horizontalStack.spacing = 16
        horizontalStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        NSLayoutConstraint.activate([
            pokemonImage.heightAnchor.constraint(equalTo: pokemonImage.widthAnchor, multiplier: 1.0),
            pokemonImage.widthAnchor.constraint(equalToConstant: 134)
        ])
        
        pokemonImage.clipsToBounds = true
        pokemonImage.contentMode = .scaleAspectFit
        
        lblPokemonName.font = UIFont.init(name: "Quicksand-Regular", size: 20)
        lblPokemonName.textColor = UIColor.init(named: "TitleColor")
        
        lblTypes.font = UIFont.init(name: "Oxygen-Bold", size: 16)
        lblTypes.textColor = .secondaryLabel
        
        addSubview(horizontalStack)
       
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func endConfig() {
        
        
        self.lblID.text = "\(self.pokemon?.id ?? 0)"
        self.lblTypes.text = "\(self.pokemon?.types?.map({ $0.type?.name ?? ""}).joined(separator: ", ") ?? "")"
    }
    
    func config(_ model: Result?) {
       
        
        self.configureTesting()
        self.lblPokemonName.text = model?.name.capitalized
        
        let pokemonFetched = service.getPokemon(fromURL: model?.url ?? "")
        
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
        
        #if targetEnvironment(macCatalyst)
            self.backgroundColor = .clear
        #endif
    }
    
    
    
    private func configureTesting() {
        self.lblID.setTestingIdentifier(UITestConstants.HomeScreen.listingCellIDLabel.rawValue)
        self.lblTypes.setTestingIdentifier(UITestConstants.HomeScreen.listingCellTypesLabel.rawValue)
        self.lblPokemonName.setTestingIdentifier(UITestConstants.HomeScreen.listingCellNameLabel.rawValue)
    }

}
