//
//  TypePokemonsViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 03/07/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TypePokemonsViewController: UIViewController, Storyboarded{
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var viewModel: TypePokemonsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureListing()
        viewModel?.getType()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureModelSelect()
    }
    
    func configureModelSelect(){
        
        self.tableView.rx.itemSelected.take(1).subscribe(onNext: { indexPath in
            if let navigation = self.navigationController, let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(identifier: PokemonDetailsViewController.identifier) as? PokemonDetailsViewController, let cell = self.tableView.cellForRow(at: indexPath) as? PokemonListingCell{
                vc.pokemon = cell.pokemon
                
                navigation.navigationItem.largeTitleDisplayMode = .always
                navigation.pushViewController(vc, animated: true)
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    func configureListing(){
        viewModel?.pokemonSpecies.asDriver(onErrorJustReturn: []).drive(tableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){index, element, cell in
            cell.config(element?.asResult())
        }.disposed(by: disposeBag)
        
    }
    
    
    
}
