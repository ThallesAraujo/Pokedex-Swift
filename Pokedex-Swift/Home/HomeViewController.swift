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
    
    let spinner = ActivityIndicator()
    
    
    func reload() {
        viewModel.getPokemonsList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPokemonsList()
        configureSearchController()
        self.configureListing()
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        self.configureSearchObservable()
        self.configureAutoLoading()
        self.configureLoading()
        self.configureErrorObserver()
    }
    
    func configureLoading(){
        //TODO: Ver mais depois. Mesmo com o resultado retornado, continua apresentando
        self.spinner.asDriver().drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
    }
    
    func configureErrorObserver(){
        //let showError = Observable.combineLatest(self.viewModel.listData, self.viewModel.searchData).map({$0.count <= 0 && $1.count <= 0})
        self.viewModel.errorHasOccurred.bind(to: self.pokemonListingTableView.rx.showError(reloadClosure: {
            self.viewModel.getPokemonsList()
        })).disposed(by: disposeBag)
        
        self.viewModel.errorHasOccurred.subscribe(onNext:{hasError in
            if hasError{
                self.viewModel.listData.accept([])
                self.viewModel.searchData.accept([])
            }
        }).disposed(by: disposeBag)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.getPokemonsList()
        self.configureListing()
        Observable.of(false).bind(to: self.pokemonListingTableView.rx.showError()).disposed(by: disposeBag)
        self.viewModel.offset = 20
    }
    
    func configureAutoLoading() {
        
        
        
        self.pokemonListingTableView.rx.contentOffset.distinctUntilChanged()
                    .map { $0.y }
            .bind(onNext: {[weak self] offset in
                
                guard let weakself = self else{return}
                let contentSize = weakself.pokemonListingTableView.contentSize.height
                
                if ((contentSize > 0) && (contentSize - offset <= 450)){
                    weakself.viewModel.getNextPage().distinctUntilChanged().timeout(.seconds(3), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] nextResults in
                        guard let weakself = self else{return}
                        var appended = weakself.viewModel.listData.value
                        let appendedSet = Set(appended)
                        let nextSet = Set(nextResults)
                        
                        if !nextSet.isSubset(of: appendedSet){
                            appended.append(contentsOf: nextResults)
                            weakself.viewModel.listData.accept(appended)
                            weakself.viewModel.offset = weakself.viewModel.offset + 20
                        }
                    }).disposed(by: weakself.disposeBag)
                }
            }).disposed(by: disposeBag)
    }
    
    func configureSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        UITextField.appearance().defaultTextAttributes = [.font: UIFont.init(name: "Oxygen-Regular", size: 14)!, .foregroundColor: UIColor.init(named: "TitleColor")!]
        UITextField.appearance().attributedPlaceholder = NSAttributedString.init(string: "Pesquisar por nome ou ID", attributes: [.font: UIFont.init(name: "Oxygen-Regular", size: 14)!, .foregroundColor: UIColor.init(named: "TitleColor")!])
        searchBar.searchTextField.backgroundColor = UIColor.init(named: "SecondaryBackgroundColor")
        searchBar.rx.text.bind(to: viewModel.searchText).disposed(by: disposeBag)
        searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self;
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureSearchObservable(){
        
        
        viewModel.searchText.distinctUntilChanged().asDriver(onErrorJustReturn: "").drive(onNext: ({[weak self] terms in
            
            guard let weakself = self else {
                return
            }
            
            guard let terms = terms, !terms.isEmpty else{
                weakself.viewModel.searchData.accept([])
                return
            }
           
            weakself.viewModel.getPokemonsResults(terms)
            weakself.configureLoadSearchData()
            
        })).disposed(by: disposeBag)
        
    }
    
    func configureLoadSearchData(){
        self.viewModel.searchData.distinctUntilChanged().asDriver(onErrorJustReturn: []).drive(self.pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){ _, element, cell in
            print("Encontrado: \(element.name)")
            cell.config(element)
        }.disposed(by: self.disposeBag)
        
        let hasErrorSearch = Observable.combineLatest(self.viewModel.searchData, self.viewModel.searchText).map({$0.count <= 0 && !($1?.isEmpty ?? false)})
        
       hasErrorSearch.bind(to: self.pokemonListingTableView.rx.showError(title: "Nenhum resultado encontrado", description: "Não foi encontrado nenhum resultado para sua pesquisa", showReload: false)).disposed(by: disposeBag)
    }
    
    
    func configureListing(){
        viewModel.listData.asDriver(onErrorJustReturn: []).drive(pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){index, element, cell in
            cell.config(element)
        }.disposed(by: disposeBag)
        
    }
    
    
    
    
}
