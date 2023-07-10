//
//  ServicesButton.swift
//  Homeworx
//
//  Created by user on 2/7/23.
//

import UIKit

class ServicesButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(.black, for: .normal)
        backgroundColor = .lightGray
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 28)
        layer.cornerRadius = 10
    }
}
