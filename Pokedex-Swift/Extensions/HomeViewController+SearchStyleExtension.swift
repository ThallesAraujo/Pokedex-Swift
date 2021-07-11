//
//  HomeViewController+SearchStyleExtension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 11/07/21.
//

import Foundation
import UIKit

extension HomeViewController{
    
    func configureSearchStyle(){
        searchController.obscuresBackgroundDuringPresentation = false
        UITextField.appearance().defaultTextAttributes = [.font: Constants.titleFont, .foregroundColor: Constants.titleColor]
        UITextField.appearance().attributedPlaceholder = NSAttributedString.init(string: Constants.searchPlaceholder, attributes: [.font: Constants.titleFont, .foregroundColor: Constants.titleColor])
        searchBar.searchTextField.backgroundColor = Constants.secondaryBackgroundColor
        searchBar.rx.text.bind(to: viewModel.searchText).disposed(by: disposeBag)
        searchBar.autocapitalizationType = .none
        if let textField = searchBar.value(forKey: Constants.searchFieldKey) as? UITextField,
            let iconView = textField.leftView as? UIImageView {

            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = Constants.titleColor
        }
        searchController.searchBar.delegate = self;
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}
