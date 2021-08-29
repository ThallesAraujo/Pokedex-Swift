//
//  CommonSteps.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 28/08/21.
//

//Baseado em: https://github.com/appcoda/SimpleNote/blob/master/SimpleNoteTakingAppTests/Steps/CommonSteps.swift

import Foundation
@testable import Pokedex_Swift
import KIF

extension KIFTestCase{
    
    /**
    Retorna para a tela Home
     */
    func popToRootViewController() {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
        let topController = keyWindow?.rootViewController as? UINavigationController
        topController?.popViewController(animated: true)
    }
    
    /**
     Mantém a barra de buscas em primeiro plano
     (por utilizar a Searchbar com Large Titles, é necessário para que a mesma não seja automaticamente ocultada
     ao retornar para a tela de home. Esse comportamento pode causar falsos negativos, pois o teste não conseguirá
     encontrar a Searchbar caso a mesma esteja oculta)
     */
    func turnSearchBarIntoFirstResponder(){
        let searchbar = tester().waitForTappableView(withAccessibilityLabel: UITestConstants.HomeScreen.searchField.rawValue)
        searchbar?.becomeFirstResponder()
    }
    
    /**
     Limpa o texto atual e digita um novo no First Responder atual
     */
    func enterTextIntoCurrentFirstResponder(_ text: String) -> Void{
        tester().clearTextFromFirstResponder()
        tester().enterText(intoCurrentFirstResponder: text)
    }
}

