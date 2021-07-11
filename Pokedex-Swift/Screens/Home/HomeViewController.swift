//
//  HomeViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, ReloadableViewController, UISearchBarDelegate {
    var retryView: ErrorView?
    
    @IBOutlet weak var pokemonListingTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar{
        return searchController.searchBar
    }
    
    var viewModel = PokemonListingViewModel()
    let disposeBag = DisposeBag()
    
    
    func reload() {
        viewModel.getPokemonsList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchObservable()
        viewModel.getPokemonsList()
        configureSearchStyle()
        self.configureListing()
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        self.configureAutoLoading()
        self.configureErrorObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureModelSelect()
    }
    
    func configureModelSelect(){
        
        self.pokemonListingTableView.rx.itemSelected.take(1).subscribe(onNext: { indexPath in
            if let navigation = self.navigationController, let vc = UIStoryboard.init(name: Constants.mainStoryboard, bundle: .main).instantiateViewController(identifier: PokemonDetailsViewController.identifier) as? PokemonDetailsViewController, let cell = self.pokemonListingTableView.cellForRow(at: indexPath) as? PokemonListingCell{
                vc.pokemon = cell.pokemon
                
                navigation.navigationItem.largeTitleDisplayMode = .always
                navigation.pushViewController(vc, animated: true)
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    func configureErrorObserver(){
        self.viewModel.errorHasOccurred.bind(to: self.pokemonListingTableView.rx.showError(reloadClosure: {
            self.viewModel.getPokemonsList()
        })).disposed(by: disposeBag)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.getPokemonsList()
        self.configureListing()
        Observable.of(false).bind(to: self.pokemonListingTableView.rx.showError()).disposed(by: disposeBag)
        self.viewModel.offset = 20
    }
    
    func configureAutoLoading() {
        self.pokemonListingTableView.rx_hasReachedTheBottom().bind(onNext: {[weak self] hasReached in
            if hasReached{
                guard let weakself = self else{return}
                weakself.viewModel.getNextPage()
            }
        }).disposed(by: disposeBag)
    }
    
    func configureSearchObservable(){
        self.viewModel.bindSearchText(configureClosure: {[weak self] in
            guard let weakself = self else { return }
            weakself.configureLoadSearchData()
        })
        
    }
    
    func configureLoadSearchData(){
        self.viewModel.searchData.distinctUntilChanged().asDriver(onErrorJustReturn: []).drive(self.pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){ _, element, cell in
            cell.config(element)
        }.disposed(by: self.disposeBag)
        
        let hasErrorSearch = Observable.combineLatest(self.viewModel.searchData, self.viewModel.searchText).map({$0.count <= 0 && !($1?.isEmpty ?? false)})
        
        hasErrorSearch.bind(to: self.pokemonListingTableView.rx.showError(title: Constants.defaultErrorTitle, description: Constants.defaultErrorDescription, showReload: false)).disposed(by: disposeBag)
    }
    
    
    func configureListing(){
        viewModel.listData.asDriver(onErrorJustReturn: []).drive(pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){index, element, cell in
            cell.config(element)
        }.disposed(by: disposeBag)
        
    }
    
    
}
