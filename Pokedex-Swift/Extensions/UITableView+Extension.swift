//
//  UITableView+RxSwiftExtension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 13/06/21.
//

import Foundation
import UIKit
import RxSwift

extension UITableView {
    
    /// Função destinada para uso com outro Driver RXSwift
    func disconnect() -> UITableView {
        self.delegate = nil
        self.dataSource = nil
        return self
    }
    
    // Baseado em https://blog.kulman.sk/simple-bindable-no-data-placeholder/
    func showEmptyView(title: String? = "", description: String? = "", showReload: Bool? = true, reloadClosure: (() -> Void)? = nil) {
        self.setNeedsLayout()
        self.setNeedsDisplay()
        let emptyView = ErrorView.init(frame: self.frame)
        
        if let title = title, !title.isEmpty {
            emptyView.lblTitle.text = title
        }
        
        if let description = description, !description.isEmpty {
            emptyView.lblDescription.text = description
        }
        
        if let showReload = showReload, !showReload {
            emptyView.btnRetry.isHidden = true
        }
        
        emptyView.retryClosure = reloadClosure
        self.backgroundView = emptyView
        emptyView.sizeToFit()
        emptyView.center = self.center
        emptyView.contentView.center = self.center
        
        emptyView.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.backgroundView?.isHidden = false
    }
    
    func hideEmptyView() {
        self.backgroundView = nil
        self.backgroundView?.isHidden = true
    }
    
    @available(*, deprecated, message: "Usar rx.willDisplayCell(onNext:) no lugar")
    func rx_hasReachedTheBottom() -> Observable<Bool> {
        return self.rx.contentOffset.distinctUntilChanged()
            .map({totalOffset -> Bool in
                let offset = totalOffset.y
                let contentSize = self.contentSize.height
                return (contentSize > 0) && (contentSize - offset <= 450)
            })
            
    }
    
}
