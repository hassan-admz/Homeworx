//
//  UIViewExtension.swift
//  Homeworx
//
//  Created by Hassan Mayers on 6/7/23.
//

import UIKit

extension UIButton {
    func setLoginOrSignUp(title: String) {
        clipsToBounds = true
        layer.cornerRadius = 5
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
        backgroundColor = .twitterBlue
    }
}

extension UIButton {
    func attributedTitle(firstText: String, secondText: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0, alpha: 0.8), .font: UIFont.systemFont(ofSize: 15)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstText) ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0, alpha: 0.8), .font: UIFont.boldSystemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "\(secondText)", attributes: boldAtts))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
    static let disabledButtonBlue = UIColor.rgb(red: 192, green: 222, blue: 237)
}

extension UIImage {
    func darkened() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return nil
        }

        // flip the image, or result appears flipped
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0, y: -size.height)

        let rect = CGRect(origin: .zero, size: size)
        ctx.draw(cgImage, in: rect)
        UIColor(white: 0, alpha: 0.5).setFill()
        ctx.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                    left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    right: NSLayoutXAxisAnchor? = nil,
                    widthNS: NSLayoutDimension? = nil,
                    paddingTop: CGFloat = 0,
                    paddingLeft: CGFloat = 0,
                    paddingBottom: CGFloat = 0,
                    paddingRight: CGFloat = 0,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        
            if let widthNS = widthNS {
                widthAnchor.constraint(equalTo: widthNS).isActive = true
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
        func center(inView view: UIView, yConstant: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
        }
        
        func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            if let topAnchor = topAnchor {
                self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
            }
        }
        
        func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
            
            if let leftAnchor = leftAnchor, let padding = paddingLeft {
                self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
            }
        }
        
        func setDimensions(width: CGFloat, height: CGFloat) {
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor.constraint(equalToConstant: width).isActive = true
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        func addConstraintsToFillView(_ view: UIView) {
            translatesAutoresizingMaskIntoConstraints = false
            anchor(top: view.topAnchor, left: view.leftAnchor,
                   bottom: view.bottomAnchor, right: view.rightAnchor)
        }
}


