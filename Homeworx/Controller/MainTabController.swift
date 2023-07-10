//
//  ViewController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 1/7/23.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeController())
        let vc2 = UINavigationController(rootViewController: SearchController())
        let vc3 = UINavigationController(rootViewController: PostServicesController())
        let vc4 = UINavigationController(rootViewController: SavedController())
        let vc5 = UINavigationController(rootViewController: ProfileController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "plus.app.fill")
        vc4.tabBarItem.image = UIImage(systemName: "heart.fill")
        vc5.tabBarItem.image = UIImage(systemName: "person.fill")
        
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Post Services"
        vc4.title = "Saved"
        vc5.title = "Profile"
        
        setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: true)
        tabBar.tintColor = .label
    }
}

