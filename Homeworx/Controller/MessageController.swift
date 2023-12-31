//
//  MessageController.swift
//  Homeworx
//
//  Created by user on 15/8/23.
//

import UIKit

class MessageController: UIViewController {
    
    // MARK: - Properties
    private var tableView = UITableView()
    private let reuseIdentifier = "reuseIdentifier"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - UI Components
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureTableView()
        fetchConversations()
    }
    
    func configureNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .twitterBlue
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        navigationItem.title = "Messages"
        
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = .none
        tableView.rowHeight = 80
        tableView.frame = view.frame
        tableView.isHidden = true
        
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
    }
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Converations!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    // MARK: - API
    
    func fetchConversations() {
        tableView.isHidden = false
    }
}

extension MessageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatController()
        vc.title = "Marco DeLeon"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)
    }
}

extension MessageController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}
