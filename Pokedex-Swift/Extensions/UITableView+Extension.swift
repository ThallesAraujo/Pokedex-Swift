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
    func showEmptyView(){
        let emptyView = EmptyView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.sizeToFit()
        self.isScrollEnabled = false
        self.backgroundView = emptyView
        self.backgroundView?.isHidden = false
    }
    
    func hideEmptyView(){
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.backgroundView?.isHidden = true
    }
    
}
