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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel.data.drive(pokemonListingTableView.rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){ _, element, cell in
            
            cell.config(element)
           
        }.disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        
    }
    
    func configureSearchController(){
        //searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Pesquisar por nome ou ID"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    

}
