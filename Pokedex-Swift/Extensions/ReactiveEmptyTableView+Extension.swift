//
//  ReactiveEmptyTableView+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 18/06/21.
//

import Foundation
import RxSwift
import UIKit
//baseado em https://blog.kulman.sk/simple-bindable-no-data-placeholder/
extension Reactive where Base: UITableView{
    
    //TODO: usar a mesma técnica com a tela de erro de rede
    
    func showError(title: String? = "", description: String? = "", showReload: Bool? = true, reloadClosure: (() -> Void)? = nil) -> Binder<Bool> {
            return Binder(base) { tableView, isEmpty in
                if isEmpty {
                    tableView.showEmptyView(title: title, description: description, showReload: showReload, reloadClosure: reloadClosure)
                } else {
                    tableView.hideEmptyView()
                }
            }
        }
}
