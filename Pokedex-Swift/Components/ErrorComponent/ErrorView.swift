//
//  EmptyView.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 16/06/21.
//

import UIKit
import CoreGraphics

class ErrorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    
    var retryClosure: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.center = self.center
        
    #if targetEnvironment(macCatalyst)
        contentView.backgroundColor = .clear
    #endif
        
    }
    
    @IBAction func didTapRetry(_ sender: Any) {
        if let retry = self.retryClosure {
            retry()
        }
    }
    
   
    
}
