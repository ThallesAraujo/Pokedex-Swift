//
//  SceneDelegate.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit

// TODO: refatorar esse cabaré
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = HomeViewController.instantiate()
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        let foregroundColor = UIColor.init(named: "TitleColor")
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "Quicksand-SemiBold", size: 18.0),
            .foregroundColor: foregroundColor
        ]
        
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "Quicksand-Medium", size: 28.0),
            .foregroundColor: foregroundColor
        ]
        
        appearance.titleTextAttributes = titleTextAttributes
        appearance.largeTitleTextAttributes = largeTitleTextAttributes
        
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = titleTextAttributes
        
        appearance.buttonAppearance = buttonAppearance
        
        navigation.navigationBar.scrollEdgeAppearance = appearance
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = titleTextAttributes
        standardAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        standardAppearance.configureWithDefaultBackground()
        
        navigation.navigationBar.standardAppearance = standardAppearance
        
        if #available(iOS 15.0, *) {
            navigation.navigationBar.compactScrollEdgeAppearance = appearance
        }
        
        navigation.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        navigation.navigationBar.titleTextAttributes = titleTextAttributes
        navigation.navigationBar.tintColor = foregroundColor
        
        let coordinator = HomeCoordinator.init(navigation: navigation)
        viewController.coordinator = coordinator
        window.rootViewController = navigation
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
}
