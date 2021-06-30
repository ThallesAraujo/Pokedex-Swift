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

class PokemonDetailsViewController: UIViewController, Storyboarded, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var pokemon: Pokemon?
    
    let indexPathHeights: [CGFloat] = [
        274,
        200,
        100,
        228,
        100,
        100
    ]
    
    let viewModel = EvolutionsViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        self.title = "(#\(pokemon?.id ?? 0)) \(pokemon?.name?.capitalized ?? "")"
        viewModel.getEvolutions(id: pokemon?.id ?? 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonBannerCell.identifier) as? PokemonBannerCell{
                cell.bannerImg.setImage(fromURL: pokemon?.sprites?.other?.dreamWorld?.frontDefault ?? "")
                return cell
            }else{
                return PokemonBannerCell()
            }
        
    }else if indexPath.row == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonImagesCell.identifier) as? PokemonImagesCell{
                cell.config(images: pokemon?.getImagesList().compactMap({$0}) ?? [])
                return cell
            }else{
                return PokemonImagesCell()
            }
        }else if indexPath.row == 2{
            //Tipos
            if let cell = tableView.dequeueReusableCell(withIdentifier:typesCellId) as? PokemonItemListCell{
                cell.config(items: pokemon?.types?.compactMap({$0.type}))
                //TODO: Did tap action
                return cell
            }else{
                return PokemonTypesCell()
            }
        }else if indexPath.row == 3{
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatsCell.identifier) as? PokemonStatsCell{
                cell.config(stats: pokemon?.stats)
                return cell
            }else{
                return PokemonStatsCell()
            }
        }else if indexPath.row == 4{
            if let cell = tableView.dequeueReusableCell(withIdentifier: pokemonAbilitiesCellId) as? PokemonItemListCell{
                let items = pokemon?.abilities?.compactMap({$0.ability})
                cell.config(items: items) {[weak self] indexPath in
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
                return cell
            }else{
                return PokemonItemListCell()
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: pokemonEvolutionsCellId) as? PokemonItemListCell{
                
                viewModel.evolution.subscribe(onNext: { evolution in
                    if let chain = evolution?.chain{
                        var evolutionChain = self.flattenChain(chain: chain)
                        evolutionChain.removeAll(where: {$0.species?.name == self.pokemon?.name})
                        cell.config(items: evolutionChain.compactMap({$0.species})) {[weak self] indexPath in
                            
                            guard let weakself = self else {return}
                            
                            let pokemonEvolution = evolutionChain[indexPath.row]
                            if let pokemonEvolutionUrl = pokemonEvolution.species?.url{
                                let fetchedPokemonEvolution = HomeService.getPokemon(fromURL: pokemonEvolutionUrl.replacingOccurrences(of: "-species", with: ""))
                                fetchedPokemonEvolution.subscribe(onNext: {pokemon in
                                    if let viewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(identifier: PokemonDetailsViewController.identifier) as? PokemonDetailsViewController{
                                        
                                        let navigation = UINavigationController.init(rootViewController: viewController)
                                        navigation.navigationBar.backgroundColor = UIColor.init(named: "MainBackgroundColor")
                                        navigation.navigationBar.barTintColor = UIColor.init(named: "MainBackgroundColor")
                                        navigation.navigationBar.largeTitleTextAttributes = [.font: UIFont.init(name: "Quicksand-SemiBold", size: 28.0), .foregroundColor: UIColor.init(named: "TitleColor")]
                                        navigation.navigationBar.titleTextAttributes = [.font: UIFont.init(name: "Quicksand-Medium", size: 14.0), .foregroundColor: UIColor.init(named: "TitleColor")]
                                        viewController.pokemon = pokemon
                                        weakself.present(navigation, animated: true, completion: nil)
                                        
                                    }
                                }).disposed(by: weakself.disposeBag)
                            }
                        }
                    }
                }).disposed(by: disposeBag)
                
                return cell
            }else{
                return PokemonFormsCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPathHeights[indexPath.row]
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


