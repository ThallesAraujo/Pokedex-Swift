//
//  UIViewController+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 30/06/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    var emptyViewTag: Int{
        return 454545
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.isAccessibilityElement = true
        alert.accessibilityLabel = message
        alert.view.tintColor = UIColor.init(named: "TitleColor")
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: {_ in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showEmptyView(title: String? = "", description: String? = "", showReload: Bool? = true, reloadClosure: (() -> Void)? = nil) {
        let emptyView = ErrorView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyView.sizeToFit()
        emptyView.tag = emptyViewTag
        
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
        
        self.view.addSubview(emptyView)
    }
    
    func hideEmptyView() {
        for view in self.view.subviews where view.tag == emptyViewTag {
                view.removeFromSuperview()
        }
        
    }
    
}
