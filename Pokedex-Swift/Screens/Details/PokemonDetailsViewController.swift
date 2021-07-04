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

let typesCellId = "pokemonTypesCell"
let pokemonEvolutionsCellId = "pokemonEvolutionsCell"
let pokemonAbilitiesCellId = "pokemonAbilitiesCell"
//TODO: error observer
class PokemonDetailsViewController: UIViewController, Storyboarded{
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonImageCarrousel: UICollectionView!
    @IBOutlet weak var pokemonTypesCollectionView: UICollectionView!
    @IBOutlet weak var pokemonStatsCollectionView: UICollectionView!
    @IBOutlet weak var pokemonAbilitiesCollectionView: UICollectionView!
    @IBOutlet weak var pokemonEvolutionsCollectionView: UICollectionView!
    
    let imageCarrousselDelegate = PokemonImagesDelegate()
    let typesDelegate = PokemonItemListDelegate()
    let statsDelegate = PokemonStatsDelegate()
    let abilitiesDelegate = PokemonItemListDelegate()
    let evolutionsDelegate = PokemonItemListDelegate()
    
    let viewModel = DetailsViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        self.title = "(#\(pokemon?.id ?? 0)) \(pokemon?.name?.capitalized ?? "")"
        viewModel.getEvolutions(id: pokemon?.id ?? 0)
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configure(){
        
        self.pokemonImage.setImage(fromURL: pokemon?.sprites?.other?.dreamWorld?.frontDefault ?? "")
        
        imageCarrousselDelegate.imagesCollectionView = self.pokemonImageCarrousel
        imageCarrousselDelegate.images = pokemon?.getImagesList().compactMap({$0}) ?? []
        imageCarrousselDelegate.reloadData()
        
        typesDelegate.itemsList = pokemonTypesCollectionView
        typesDelegate.config(items: pokemon?.types?.compactMap({$0.type})) {[weak self] indexPath in
            guard let weakself = self else {return}
            
            if let pokemonType = weakself.pokemon?.types?[indexPath.row].type, let pokemonTypeUrl = pokemonType.url{
                if let viewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(identifier: TypePokemonsViewController.identifier) as? TypePokemonsViewController{
                    viewController.title = pokemonType.name?.capitalized
                    
                    let viewModel = TypePokemonsViewModel.init()
                    viewModel.pokemonType = pokemonType
                    viewController.viewModel = viewModel
                    weakself.navigationController?.pushViewController(viewController, animated: true)
                    
                }
            }
        }
        
        statsDelegate.statsCollectionView = self.pokemonStatsCollectionView
        statsDelegate.stats = pokemon?.stats
        statsDelegate.reloadData()
        
        
        
        abilitiesDelegate.itemsList = pokemonAbilitiesCollectionView
        abilitiesDelegate.config(items: pokemon?.abilities?.compactMap({$0.ability})) {[weak self] indexPath in
            guard let weakself = self else{return}
            
            if let ability = weakself.pokemon?.abilities?[indexPath.row], let abilityUrl = ability.ability?.url {
                let details = DetailsService.getAbility(fromURL: abilityUrl)
                let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
                
                details.subscribe(onNext: {detail in
                    let abilityName = ability.ability?.name ?? ""
                    
                    let message = detail.flavorTextEntries?.first(where: {$0.language?.name == "en"})?.flavorText ?? ""
                    
                    if !abilityName.isEmpty && !message.isEmpty{
                        keyWindow?.rootViewController?.showAlert(title: abilityName.capitalized, message: message)
                    }
                    
                }).disposed(by: weakself.disposeBag)
            }
        }
        
       
        
        
        viewModel.evolution.subscribe(onNext: {[weak self] evolution in
            if let chain = evolution?.chain{
                guard let weakself = self else {return}
                var evolutionChain = weakself.flattenChain(chain: chain)
                evolutionChain.removeAll(where: {$0.species?.name == weakself.pokemon?.name})
                
                let items = evolutionChain.compactMap({$0.species})
                
                print("Evolucoes do pokemon: \(items.count) | \(items.compactMap({$0.name}).joined(separator: ","))")
                

                weakself.evolutionsDelegate.itemsList = weakself.pokemonEvolutionsCollectionView
                weakself.evolutionsDelegate.config(items: items) { [weak self] indexPath in
                    
                    guard let weakself = self else {return}
                    
                    let pokemonEvolution = evolutionChain[indexPath.row]
                    if let pokemonEvolutionUrl = pokemonEvolution.species?.url{
                        let fetchedPokemonEvolution = HomeService.getPokemon(fromURL: pokemonEvolutionUrl.replacingOccurrences(of: "-species", with: ""))
                        fetchedPokemonEvolution.subscribe(onNext: {pokemon in
                            if let viewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(identifier: PokemonDetailsViewController.identifier) as? PokemonDetailsViewController{
                                
                                viewController.pokemon = pokemon
                                weakself.navigationController?.pushViewController(viewController, animated: true)
                                
                            }
                        }).disposed(by: weakself.disposeBag)
                    }
                }
                }
                
               
        }).disposed(by: disposeBag)
        
        
    }
    
   
   

    func flattenChain(chain: Chain) -> [Chain]{
        
        
        var chains: [Chain] = []
        
        if let evolutions = chain.evolvesTo, evolutions.count > 0{
            chains.append(chain)
            chains.append(contentsOf: flattenChain(chain: evolutions[0]))
            chains.append(contentsOf: evolutions[0].evolvesTo ?? [])
        }else{
            chains.append(chain)
        }
        
        return chains.withoutDuplicates()
        
    }
    

    
}


