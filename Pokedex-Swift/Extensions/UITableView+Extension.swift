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
    
}
