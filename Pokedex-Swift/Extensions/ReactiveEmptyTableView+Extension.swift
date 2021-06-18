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
    func isEmpty() -> Binder<Bool> {
            return Binder(base) { tableView, isEmpty in
                if isEmpty {
                    tableView.showEmptyView()
                } else {
                    tableView.hideEmptyView()
                }
            }
        }
}
