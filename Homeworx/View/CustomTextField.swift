//
//  CustomTextField.swift
//  Homeworx
//
//  Created by user on 12/7/23.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        borderStyle = .roundedRect
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
        clipsToBounds = true
        textColor = .black
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        keyboardAppearance = .default
        keyboardType = .emailAddress
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 0.5, alpha: 0.5)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
