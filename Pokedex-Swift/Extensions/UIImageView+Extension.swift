//
//  UIImageViewExtension.swift
//  Bicycle Shop
//
//  Created by Thalles Araújo on 28/06/20.
//
import Foundation
import UIKit
import SDWebImageSVGCoder

extension UIImageView{
    
    func setImage(fromURL url: String){
        
        
        if let urlImage = URL.init(string: url){
            self.sd_imageTransition = .fade
            self.sd_setImage(with: urlImage, placeholderImage: UIImage.init(named: "image_placeholder"), options: [.forceTransition])
        }
        
    }
    
}
