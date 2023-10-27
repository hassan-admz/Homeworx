//
//  ProfileController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 1/7/23.
//

import UIKit
import Firebase

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    private var user: User?
    private lazy var headerView = ProfileHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 300))
    private lazy var footerView = ProfileFooterView()
    private let reuseIdentifier = "reuseIdentifier"
    private let cellData = [
        ("Fullname", "Iylia Mayers"),
        ("Email", "iy.nurliyana@gmail.com"),
        ("Password","Mahdi313")
    ]
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
   }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("\(uid)")
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            print("The username of the current user is: \(user.username)")
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barStyle = .black
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = headerView
        headerView.backgroundColor = .systemBlue
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.separatorColor = .darkGray
        
        // Footer View
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 300)
        tableView.tableFooterView = footerView
        let logoutButton = footerView.getLogoutButton()
        logoutButton.addTarget(self, action: #selector(logUserOut), for: .touchUpInside)
        
        let deleteAccountButton = footerView.getDeleteAccountButton()
        deleteAccountButton.addTarget(self, action: #selector(deleteUserAccount), for: .touchUpInside)
        
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
    
    func didTapDeleteAccount() {
        showDeleteAccountConfirmationAlert()
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            // An error happened.
              print(error.localizedDescription)
          } else {
            // Account deleted.
              self.presentLoginScreen()
            print("Account Deleted")
          }
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
    
    func showDeleteAccountConfirmationAlert() {
        let alert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account? This will permanently erase your account.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive){ [weak self] (_) in
            self?.deleteAccount() // Call the deleteAccount function
        })
        self.present(alert, animated: true)
    }
    
    // MARK: - Selectors
    
    @objc func logUserOut() {
        logout()
    }
    
    @objc func deleteUserAccount() {
        didTapDeleteAccount()
    }
    
    @objc func didTapButton() {
        print("Tapped!")
    }
}

extension ProfileController {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileTableViewCell
        let (title, subtitle) = cellData[indexPath.row]
        
        cell.titleLabel.text = title
        cell.subtitleLabel.text = subtitle
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}


