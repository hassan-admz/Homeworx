//
//  HomeController.swift
//  Homeworx
//
//  Created by user on 1/7/23.
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    let man = UIImage()
    
    func addButtonsToStackView() {
        let buttonTitle = ["AC Repair","Plumbing","Electrical","Appliance Repair","Cleaning","Painting","Moving"]
        var imageNum = 0

        for title in buttonTitle {
            let button = ServicesButton()
            button.setTitle("\(title)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            button.setBackgroundImage(images[imageNum].withTintColor(.darkGray).withAlpha(0.1), for: .normal)
            stackView.addArrangedSubview(button)
            imageNum += 1
        }
    }
}


struct HomeViewController_Previews: PreviewProvider {
  static var previews: some View {
    Container().edgesIgnoringSafeArea(.all)
  }
  struct Container: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
      UINavigationController(rootViewController: HomeController())
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    typealias UIViewControllerType = UIViewController
  }
}
