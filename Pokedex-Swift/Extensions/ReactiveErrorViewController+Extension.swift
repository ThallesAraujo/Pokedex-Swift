//
//  ReactiveErrorViewController+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 04/07/21.
//

import Foundation
import RxSwift
import UIKit
//baseado em https://blog.kulman.sk/simple-bindable-no-data-placeholder/
extension Reactive where Base: UIViewController{
    
    func showError(title: String? = "", description: String? = "", showReload: Bool? = true, reloadClosure: (() -> Void)? = nil) -> Binder<Bool> {
            return Binder(base) { viewController, hasError in
                if hasError {
                    viewController.showEmptyView(title: title, description: description, showReload: showReload, reloadClosure: reloadClosure)
                } else {
                    viewController.hideEmptyView()
                }
            }
    }
    
}
