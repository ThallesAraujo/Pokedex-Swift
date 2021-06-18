//
//  HomeViewController.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonListingTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar{
        return searchController.searchBar
    }
    
    var viewModel = PokemonListingViewModel()
    let disposeBag = DisposeBag()
    
    let spinner = ActivityIndicator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPokemonsList()
        configureSearchController()
        self.configureListing()
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        self.configureSearchObservable()
        self.configureAutoLoading()
        self.configureLoading()
    }
    
    func configureLoading(){
        //TODO: Ver mais depois. Mesmo com o resultado retornado, continua apresentando
        self.spinner.asDriver().drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.configureListing()
        Observable.of(false).bind(to: self.pokemonListingTableView.rx.isEmpty()).disposed(by: disposeBag)
    }
    
    func configureAutoLoading() {
        
        self.pokemonListingTableView.rx.contentOffset
                    .map { $0.y }
            .bind(onNext: {[weak self] offset in
                
                guard let weakself = self else{return}
                let contentSize = weakself.pokemonListingTableView.contentSize.height
                
                if ((contentSize > 0) && (contentSize - offset <= 600)){
                    weakself.viewModel.getNextPage().subscribe(onNext: { [weak self] nextResults in
                        guard let weakself = self else{return}
                        var appended = weakself.viewModel.listData.value
                        appended.append(contentsOf: nextResults)
                        weakself.viewModel.listData.accept(appended)
                        weakself.viewModel.offset = weakself.viewModel.offset + 20
                    }).disposed(by: weakself.disposeBag)
                    weakself.viewModel.offset = weakself.viewModel.offset + 20
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
            cell.config(element)
        }.disposed(by: self.disposeBag)
        
        viewModel.searchData.map({$0.count <= 0}).bind(to: self.pokemonListingTableView.rx.isEmpty()).disposed(by: disposeBag)
    }
    
    func configureEmptyView(isVisible: Bool){
        
        let emptyView = EmptyView.init(frame:self.pokemonListingTableView.frame)
        emptyView.tag = -9999
        if isVisible{
            self.pokemonListingTableView.addSubview(emptyView)
        }else{
            for view in self.pokemonListingTableView.subviews{
                if view.tag == -9999{
                    view.removeFromSuperview()
                    view.isHidden = true
                }
            }
        }
    }
    
    func configureListing(){
        viewModel.listData.asDriver(onErrorJustReturn: []).drive(pokemonListingTableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)){index, element, cell in
            cell.config(element)
        }.disposed(by: disposeBag)
    }
    
    
    
    
}
