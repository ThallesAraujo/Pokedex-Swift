//
//  UITableView+RxSwiftExtension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 13/06/21.
//

import Foundation
import UIKit


extension UITableView{
    
    ///Função destinada para uso com outro Driver RXSwift
    func disconnect() -> UITableView{
        self.delegate = nil
        self.dataSource = nil
        return self
    }
    
    //Baseado em https://blog.kulman.sk/simple-bindable-no-data-placeholder/
    func showEmptyView(title: String? = "", description: String? = "", showReload: Bool? = true, reloadClosure: (() -> Void)? = nil){
        let emptyView = ErrorView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.sizeToFit()
        
        if let title = title, !title.isEmpty{
            emptyView.lblTitle.text = title
        }
        
        if let description = description, !description.isEmpty{
            emptyView.lblDescription.text = description
        }
        
        if let showReload = showReload, !showReload{
            emptyView.btnRetry.isHidden = true
        }
        
        emptyView.retryClosure = reloadClosure
        
        //self.isScrollEnabled = false
        self.backgroundView = emptyView
        self.backgroundView?.isHidden = false
    }
    
    func hideEmptyView(){
        //self.isScrollEnabled = true
        self.backgroundView = nil
        self.backgroundView?.isHidden = true
    }
    
}
