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
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 200))
    private let reuseIdentifier = "reuseIdentifier"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - API
    
    func fetchUser() {
        
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: - Selectors
    
}

extension ProfileController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
}


