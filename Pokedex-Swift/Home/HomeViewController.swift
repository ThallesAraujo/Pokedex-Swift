//
//  HomeViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pokemonListingTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar{
        return searchController.searchBar
    }
    
    var viewModel = PokemonListingViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        self.configureListing()
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        self.configureSearchObservable()
    }
    
    func configureSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Pesquisar por nome ou ID"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureSearchObservable(){
        viewModel.searchText.subscribe(onNext: ({[weak self] terms in
            
            guard let weakself = self else {return }
            
            if !terms.isEmpty{
                weakself.viewModel.searchData.drive(weakself.pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){ _, element, cell in
                    cell.config(element)
                    
                }.disposed(by: weakself.disposeBag)
            }else{
                weakself.configureListing()
            }
        })).disposed(by: disposeBag)
    }
    
    func configureListing(){
        viewModel.listData.drive(pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){ index, element, cell in
            cell.config(element)
            
        }.disposed(by: disposeBag)
    }
    
    
    
    
}
