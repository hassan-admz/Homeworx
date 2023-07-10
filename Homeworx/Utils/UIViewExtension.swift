//
//  UIViewExtension.swift
//  Homeworx
//
//  Created by user on 6/7/23.
//

import UIKit

extension UIView {
func addoverlay(color: UIColor = .black, alpha : CGFloat = 0.6) {
    let overlay = UIView()
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.frame = bounds
    overlay.backgroundColor = color
    overlay.alpha = alpha
    addSubview(overlay)
    }
    //This function will add a layer on any `UIView` to make that `UIView` look darkened
}
