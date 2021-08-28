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
    
    //Adaptado para as novas scenes do iOS 13
    func popToRootViewController() {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
        let topController = keyWindow?.rootViewController as? UINavigationController
        topController?.popViewController(animated: true)
    }
    
    func turnSearchBarIntoFirstResponder(){
        let searchbar = tester().waitForTappableView(withAccessibilityLabel: UITestConstants.HomeScreen.searchField.rawValue)
        searchbar?.becomeFirstResponder()
    }
    
}

