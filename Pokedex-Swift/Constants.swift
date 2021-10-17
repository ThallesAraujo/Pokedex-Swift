//
//  Constants.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 11/07/21.
//

import Foundation
import UIKit

class Constants {
    
    // MARK: - UI Constants
    
    static let mainStoryboard = "Main"
    
    static let searchPlaceholder = "Pesquisar por nome ou ID"
    static let searchFieldKey = "searchField"

    static let titleFont = UIFont.init(name: "Oxygen-Regular", size: 14)!
    static let titleColor = UIColor.init(named: "TitleColor")!
    static let secondaryBackgroundColor = UIColor.init(named: "SecondaryBackgroundColor")
    
    static let defaultErrorTitle = "Nenhum resultado encontrado"
    static let defaultErrorDescription = "Não foi encontrado nenhum resultado para sua pesquisa"
    
    // MARK: - model comparation
    
    static let defaultLanguage = "en"
    
}
