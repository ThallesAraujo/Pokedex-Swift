//
//  PokemonDetailsViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 26/06/21.
//

import Foundation
import UIKit

class PokemonDetailsViewController: UIViewController, Storyboarded, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        self.title = pokemon?.name?.capitalized
    }
    
    let indexPathHeights: [CGFloat] = [
        274,
        200,
        50,
        228,
        100,
        200
    ]
    
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
                cell.config(forms: pokemon?.forms)
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
    
    
    
}


