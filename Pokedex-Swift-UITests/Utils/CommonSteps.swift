//
//  CommonSteps.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 28/08/21.
//

// Baseado em: https://github.com/appcoda/SimpleNote/blob/master/SimpleNoteTakingAppTests/Steps/CommonSteps.swift

import Foundation
@testable import Pokedex_Swift
import KIF

extension KIFTestCase {
    
    /**
    Retorna para a tela Home
     */
    func popToRootViewController() {
        
        let appWindows = UIApplication.shared.windows
        
        let keyWindow = appWindows.first(where: { $0.isKeyWindow }) ?? appWindows.first
        let topController = keyWindow?.rootViewController as? UINavigationController
        topController?.popViewController(animated: true)
    }
    
    /**
     Mantém a barra de buscas em primeiro plano
     (por utilizar a Searchbar com Large Titles, é necessário para que a mesma não seja automaticamente ocultada
     ao retornar para a tela de home. Esse comportamento pode causar falsos negativos, pois o teste não conseguirá
     encontrar a Searchbar caso a mesma esteja oculta)
     */
    func turnSearchBarIntoFirstResponder() {
        
        let searchBarIdentifier = UITestConstants.HomeScreen.searchField.rawValue
        let searchbar = tester().waitForTappableView(withAccessibilityLabel: searchBarIdentifier)
        searchbar?.becomeFirstResponder()
    }
    
    /**
     Limpa o texto atual e digita um novo no First Responder atual
     */
    func enterTextIntoCurrentFirstResponder(_ text: String) {
        tester().clearTextFromFirstResponder()
        tester().enterText(intoCurrentFirstResponder: text)
    }
}
