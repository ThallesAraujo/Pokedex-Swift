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

class PokemonDetailsViewController: UIViewController, Storyboarded, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var pokemon: Pokemon?
    
    let indexPathHeights: [CGFloat] = [
        274,
        200,
        50,
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTypesCell.identifier) as? PokemonTypesCell{
                cell.lblPokemonTypes.text = "Tipos: \(pokemon?.types?.compactMap({$0.type?.name}).joined(separator: ", ") ?? "")"
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonAbilitiesCell.identifier) as? PokemonAbilitiesCell{
                cell.config(abilities: pokemon?.abilities)
                return cell
            }else{
                return PokemonAbilitiesCell()
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonFormsCell.identifier) as? PokemonFormsCell{
                
                viewModel.evolution.subscribe(onNext: { evolution in
                    if let chain = evolution?.chain{
                        var evolutionChain = self.flattenChain(chain: chain)
                        evolutionChain.removeAll(where: {$0.species?.name == self.pokemon?.name})
                        cell.config(forms: evolutionChain)
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


