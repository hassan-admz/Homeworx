//
//  HomeController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 1/7/23.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    lazy var stackView = UIStackView()
    lazy var scrollView = UIScrollView()
    lazy var images: [UIImage] = [
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
        configureUI()
        authenticateUser()
    }
    
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: User is NOT logged in. Present login screen here.")
            presentLoginScreen()
        } else {
            print("DEBUG: User IS logged in. Configure HomeController.")
        }
    }
    
    // MARK: - Actions
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    // MARK: - UI Components
    
    func configureUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Services"
        addMessageButton()
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
            lazy var button = ServicesButton()
            button.setTitle("\(title)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitleColor(.white, for: .normal)
            button.anchor(height: 100)
            button.setBackgroundImage(images[imageNum].darkened()?.compressed(quality: 0.0), for: .normal)
            button.clipsToBounds = true
            stackView.addArrangedSubview(button)
            imageNum += 1
        }
    }
    
    func addMessageButton() {
//        let msgBtn = UIButton(type: .system)
//        msgBtn.setBackgroundImage(UIImage(systemName: "message"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(logUserOut))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    // MARK: - Selectors
    
    @objc func didTapMessageButton() {
        print("Tapped!")
    }
    
    @objc func logUserOut() {
        logout()
    }
}

