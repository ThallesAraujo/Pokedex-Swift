//
//  PokemonDetailsViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PokemonDetailsViewController: BaseController, Storyboarded {
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonImageCarrousel: UICollectionView!
    @IBOutlet weak var pokemonTypesCollectionView: UICollectionView!
    @IBOutlet weak var pokemonStatsCollectionView: UICollectionView!
    @IBOutlet weak var pokemonAbilitiesCollectionView: UICollectionView!
    @IBOutlet weak var pokemonEvolutionsCollectionView: UICollectionView!
    
    var imageCarrousselDelegate = PokemonImagesDelegate()
    var typesDelegate = PokemonItemListDelegate()
    var statsDelegate = PokemonStatsDelegate()
    var abilitiesDelegate = PokemonItemListDelegate()
    var evolutionsDelegate = PokemonItemListDelegate()
    
    let viewModel = DetailsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "(#\(pokemon?.id ?? 0)) \(pokemon?.name?.capitalized ?? "")"
        viewModel.getEvolutions(id: pokemon?.id ?? 0)
        configure()
        configureErrorObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureErrorObserver() {
        self.viewModel.errorHasOccurred.bind(to: self.rx.showError(reloadClosure: {
            self.viewModel.getEvolutions(id: self.pokemon?.id ?? 0)
        })).disposed(by: disposeBag)
    }
    
    func configure() {
        
        self.pokemonImage.setImage(fromURL: pokemon?.sprites?.other?.dreamWorld?.frontDefault ?? "")
        
        imageCarrousselDelegate.config(images: pokemon?.getImagesList().compactMap({$0}) ?? [], collectionView: self.pokemonImageCarrousel)
        
        typesDelegate.config(collectionView: pokemonTypesCollectionView, items: pokemon?.types?.compactMap({$0.type}), actionType: .pokemonsOfSameType, navigation: self.navigationController)
        
        statsDelegate.config(collectionView: pokemonStatsCollectionView, stats: pokemon?.stats)
        
        abilitiesDelegate.config(collectionView: pokemonAbilitiesCollectionView, items: pokemon?.abilities?.compactMap({$0.ability}), actionType: .seeAbility, navigation: self.navigationController)
        
        viewModel.evolution.subscribe(onNext: {[weak self] evolution in
            if let chain = evolution?.chain {
                guard let weakself = self else {return}
                var evolutionChain = weakself.flattenChain(chain: chain)
                evolutionChain.removeAll(where: {$0.species?.name == weakself.pokemon?.name})
                
                let items = evolutionChain.compactMap({$0.species})
                
                weakself.evolutionsDelegate.config(collectionView: weakself.pokemonEvolutionsCollectionView, items: items, actionType: .seeEvolution, navigation: weakself.navigationController)
            }
            
        }).disposed(by: disposeBag)
    }
    
    func flattenChain(chain: Chain) -> [Chain] {
        var chains: [Chain] = []
        
        if let evolutions = chain.evolvesTo, evolutions.count > 0 {
            chains.append(chain)
            chains.append(contentsOf: flattenChain(chain: evolutions[0]))
            chains.append(contentsOf: evolutions[0].evolvesTo ?? [])
        } else {
            chains.append(chain)
        }
        
        return chains.withoutDuplicates()
    }
    
}
