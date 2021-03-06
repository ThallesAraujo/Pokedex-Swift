//
//  UIImageViewExtension.swift
//  Bicycle Shop
//
//  Created by Thalles Araújo on 28/06/20.
//
import Foundation
import UIKit
import SDWebImageSVGCoder
import Kingfisher
import UIImageColors
// swiftlint:disable line_length

extension UIImageView {
    
    func setImage(fromURL url: String) {
        
        if let urlImage = URL.init(string: url) {
            self.sd_imageTransition = .fade
            self.sd_setImage(with: urlImage, placeholderImage: UIImage.init(named: "image_placeholder"), options: [.forceTransition])
        }
    }
    
    func getDominantColor(fromURL url: String, toTintView view: UIView) {
        self.kf.setImage(with: URL.init(string: url), placeholder: UIImage.init(named: "image_placeholder"), options: [.forceRefresh], progressBlock: nil) { image, _, _, _ in
            view.backgroundColor = image?.getColors()?.primary
        }
    }
    
    func kf_setImage(url: String) {
            self.kf.setImage(with: URL.init(string: url), placeholder: UIImage.init(named: "image_placeholder"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        }
    
}
