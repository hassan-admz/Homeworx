//
//  ProfileFooterView.swift
//  Homeworx
//
//  Created by Hassan Mayers on 21/10/23.
//

import UIKit
import Firebase

class ProfileFooterView: UIView {
    
    // MARK: - UI Elements

        let logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .systemPink
        btn.isEnabled = true
//        btn.addTarget(self, action: #selector(logUserOut), for: .touchUpInside)
        return btn
    }()
    
        let deleteAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Delete Account", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.isEnabled = true
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        setupLogoutButton()
        setupDeleteAccountButton()
    }
    
    func setupLogoutButton() {
        addSubview(logoutButton)
        logoutButton.centerX(inView: self)
        logoutButton.setDimensions(width: 340, height: 50)
        logoutButton.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 21)
    }
    
    func setupDeleteAccountButton() {
        addSubview(deleteAccountButton)
        deleteAccountButton.centerX(inView: self)
        deleteAccountButton.anchor(top: logoutButton.bottomAnchor, paddingTop: 150)
    }
    
    func getLogoutButton() -> UIButton {
           return logoutButton
       }
    
    func getDeleteAccountButton() -> UIButton {
        return deleteAccountButton
    }
}
