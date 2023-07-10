//
//  HomeController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 1/7/23.
//

import UIKit
import SwiftUI

class HomeController: UIViewController {
    
    var stackView = UIStackView()
    var scrollView = UIScrollView()
    var images: [UIImage] = [
        UIImage(named: "ac-repair")!,
        UIImage(named: "plumbing")!,
        UIImage(named: "electrical")!,
        UIImage(named: "appliance-repair1")!,
        UIImage(named: "cleaning")!,
        UIImage(named: "painting")!,
        UIImage(named: "mover")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.navigationItem.title = "Services"
        configureScrollView()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        setScrollViewConstraints()
        configureStackView()
    }
    
    func setScrollViewConstraints() {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.safeAreaLayoutGuide.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor,paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 20)
    }
    
    func configureStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        setStackViewConstraints()
        addButtonsToStackView()
    }
    
    func setStackViewConstraints() {
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, widthNS: scrollView.widthAnchor)
    }
    
    func addButtonsToStackView() {
        let buttonTitle = ["AC Repair","Plumbing","Electrical","Appliance Repair","Cleaning","Painting","Moving"]
        var imageNum = 0

        for title in buttonTitle {
            let button = ServicesButton()
            button.setTitle("\(title)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitleColor(.white, for: .normal)
            button.anchor(height: 100)
            button.setBackgroundImage(images[imageNum].darkened(), for: .normal)
            button.clipsToBounds = true
            stackView.addArrangedSubview(button)
            imageNum += 1
        }
    }
}

