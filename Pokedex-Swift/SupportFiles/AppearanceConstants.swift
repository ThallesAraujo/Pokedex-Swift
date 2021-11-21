//
//  AppearanceConstants.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 21/11/21.
//

import Foundation
import UIKit

class AppDefaultFonts {
    
    let quicksandSemibold = UIFont.init(name: "Quicksand-SemiBold", size: 18.0)!
    let quicksandMedium =  UIFont.init(name: "Quicksand-Medium", size: 28.0)!
    
}

class AppDefaultColors {
    
    let standardForegroundColor = UIColor.init(named: "TitleColor")!
    
}

class AppNavigationBarTitleAttributes {
    
    let standardTitleTextAttributes: [NSAttributedString.Key: Any] = [
        .font: AppDefaultFonts().quicksandSemibold,
        .foregroundColor: AppDefaultColors().standardForegroundColor
    ]
    
    let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
        .font: AppDefaultFonts().quicksandMedium,
        .foregroundColor: AppDefaultColors().standardForegroundColor
    ]
    
}
