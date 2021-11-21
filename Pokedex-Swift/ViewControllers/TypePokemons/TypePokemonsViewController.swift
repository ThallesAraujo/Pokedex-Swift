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

class TypePokemonsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var viewModel: TypePokemonsViewModel?
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureListing()
        viewModel?.getType()
        configureErrorObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureModelSelect()
    }
    
    func configureErrorObserver() {
        self.viewModel?.errorHasOccurred.bind(to: self.rx.showError(reloadClosure: {
            self.viewModel?.getType()
        })).disposed(by: disposeBag)
    }
    
    func configureModelSelect() {
        
        self.tableView.rx.itemSelected.take(1).subscribe(onNext: { indexPath in
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PokemonListingCell else {
                return
            }
            
            self.coordinator?.presentNextScreen(data: cell.pokemon)
            
        }).disposed(by: disposeBag)
        
    }
    
    func configureListing() {
        
        // swiftlint:disable:next line_length
        viewModel?.pokemonSpecies.asDriver(onErrorJustReturn: []).drive(tableView.disconnect().rx.items(cellIdentifier: PokemonListingCell.identifier, cellType: PokemonListingCell.self)) { _, element, cell in
            cell.config(element?.asResult())
        }.disposed(by: disposeBag)
        
    }
    
}
