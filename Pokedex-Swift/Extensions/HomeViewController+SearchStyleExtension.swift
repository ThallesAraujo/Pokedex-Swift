//
//  HomeViewController+SearchStyleExtension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 11/07/21.
//

import Foundation
import UIKit

let titleColor = Constants.titleColor
let titleFont = Constants.titleFont
let searchPlaceholder = Constants.searchPlaceholder

extension HomeViewController {
    
    func configureSearchStyle() {
        
        let defaultAttributes: [NSAttributedString.Key: Any] = [.font: titleFont, .foregroundColor: titleColor]
        searchController.obscuresBackgroundDuringPresentation = false
        UITextField.appearance().defaultTextAttributes = defaultAttributes
        UITextField.appearance().attributedPlaceholder = NSAttributedString.init(string: searchPlaceholder, attributes: defaultAttributes)
        searchBar.rx.text.bind(to: viewModel.searchText).disposed(by: disposeBag)
        searchBar.autocapitalizationType = .none
        if let textField = searchBar.value(forKey: Constants.searchFieldKey) as? UITextField,
            let iconView = textField.leftView as? UIImageView {

            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = Constants.titleColor
        }
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        #if !targetEnvironment(macCatalyst)
        searchBar.searchTextField.backgroundColor = Constants.secondaryBackgroundColor
        #endif
        
    }
    
}
