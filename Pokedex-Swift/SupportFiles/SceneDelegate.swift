//
//  SceneDelegate.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = HomeViewController.instantiate()
        let navigation = configureAppearance(rootViewController: viewController)
        
        let coordinator = HomeCoordinator.init(navigation: navigation)
        viewController.coordinator = coordinator
        window.rootViewController = navigation
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func configureAppearance(rootViewController: UIViewController) -> UINavigationController {
        
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
       
        appearance.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        appearance.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        
        appearance.buttonAppearance = buttonAppearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        standardAppearance.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.buttonAppearance = buttonAppearance
        
        navigation.navigationBar.standardAppearance = standardAppearance
        
        if #available(iOS 15.0, *) {
            navigation.navigationBar.compactScrollEdgeAppearance = appearance
        }
        
        navigation.navigationBar.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        navigation.navigationBar.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        navigation.navigationBar.tintColor = AppDefaultColors().standardForegroundColor
        
        return navigation
    }
    
}
