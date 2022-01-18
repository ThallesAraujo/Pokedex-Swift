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
        
        
        let splitViewController: UISplitViewController = configureAppearance(rootViewController: viewController)
        
        let noniPhoneUI = {
            let coordinator = HomeCoordinator.init(navigation: splitViewController)
            viewController.coordinator = coordinator
            window.rootViewController = splitViewController
        }
        
        #if targetEnvironment(macCatalyst)
            noniPhoneUI()
        #else
        if UIDevice.current.userInterfaceIdiom == .pad{
           noniPhoneUI()
        }else{
            let navigation: UINavigationController = configureAppearance(rootViewController: viewController)
            let coordinator = HomeCoordinator.init(navigation: navigation)
            viewController.coordinator = coordinator
            print("Sistema não é macOS")
            window.rootViewController = navigation
        }
        #endif
        
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
            navigation.navigationBar.compactAppearance = appearance
        }
        
        navigation.navigationBar.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        navigation.navigationBar.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        navigation.navigationBar.tintColor = AppDefaultColors().standardForegroundColor
        
        return navigation
    }
    
    private func configureAppearance(rootViewController: UIViewController) -> UISplitViewController {
        
        let navigation = UISplitViewController.init(style: .doubleColumn)
        
        navigation.setViewController(rootViewController, for: .primary)
        navigation.primaryBackgroundStyle = .sidebar
        
        navigation.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
       
        appearance.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        appearance.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        
        appearance.buttonAppearance = buttonAppearance
        navigation.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        standardAppearance.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.buttonAppearance = buttonAppearance
        
        navigation.navigationController?.navigationBar.standardAppearance = standardAppearance
        
        if #available(iOS 15.0, *) {
            navigation.navigationController?.navigationBar.compactAppearance = appearance
        }
        
        navigation.navigationController?.navigationBar.largeTitleTextAttributes = AppNavigationBarTitleAttributes().largeTitleTextAttributes
        navigation.navigationController?.navigationBar.titleTextAttributes = AppNavigationBarTitleAttributes().standardTitleTextAttributes
        navigation.navigationController?.navigationBar.tintColor = AppDefaultColors().standardForegroundColor
        navigation.displayModeButtonItem.tintColor = AppDefaultColors().standardForegroundColor
        
        navigation.navigationController?.navigationBar.barTintColor = AppDefaultColors().standardForegroundColor
        
        navigation.displayModeButtonItem.tintColor = AppDefaultColors().standardForegroundColor
        
        navigation.view.tintColor = AppDefaultColors().standardForegroundColor
        
        return navigation
    }
    
}
