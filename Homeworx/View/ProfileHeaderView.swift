//
//  ProfileHeader.swift
//  Homeworx
//
//  Created by user on 26/8/23.
//

import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: - Properties
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Iylia")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 70
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Iylia110"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        return lbl
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
        setupProfileImage()
        setupUsernameLabel()
    }
    
    func setupProfileImage() {
        addSubview(profileImage)
        profileImage.centerX(inView: self)
        profileImage.setDimensions(width: 140, height: 140)
        profileImage.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 10)
    }
    
    func setupUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.centerX(inView: self)
        usernameLabel.anchor(top: profileImage.bottomAnchor, paddingTop: 20)
    }
}
