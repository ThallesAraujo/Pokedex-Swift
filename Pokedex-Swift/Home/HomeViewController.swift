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
        viewModel.getPokemonsList()
        configureSearchController()
        self.configureListing()
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        self.configureSearchObservable()
        self.configureAutoLoading()
    }
    
    func configureAutoLoading() {
        
        self.pokemonListingTableView.rx.contentOffset
                    .map { $0.y }
            .bind(onNext: { offset in
                
                if ((self.pokemonListingTableView.contentSize.height > 0) && (self.pokemonListingTableView.contentSize.height - offset <= 600)){
                    self.viewModel.getNextPage().subscribe(onNext: {nextResults in
                        
                        var appended = self.viewModel.listData.value
                        appended.append(contentsOf: nextResults)
                        
                        self.viewModel.listData.accept(appended)
                        self.viewModel.offset = self.viewModel.offset + 20
                        
                        
                    })
                    self.viewModel.offset = self.viewModel.offset + 20
                }
            }).disposed(by: disposeBag)
    }
    
    func configureSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        UITextField.appearance().defaultTextAttributes = [.font: UIFont.init(name: "Oxygen-Regular", size: 14)!, .foregroundColor: UIColor.init(named: "TitleColor")!]
        UITextField.appearance().attributedPlaceholder = NSAttributedString.init(string: "Pesquisar por nome ou ID", attributes: [.font: UIFont.init(name: "Oxygen-Regular", size: 14)!, .foregroundColor: UIColor.init(named: "TitleColor")!])
        searchBar.searchTextField.backgroundColor = UIColor.init(named: "SecondaryBackgroundColor")

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
        viewModel.listData.asDriver().drive(pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){ index, element, cell in
            cell.config(element)
            
        }.disposed(by: disposeBag)
    }
    
    
    
    
}
