//
//  TabBarViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = UIColor(hexCode: "FFDFD9")
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        
        let home = HomeViewController()
        let nav1 = UINavigationController(rootViewController: home)
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let favorite = FavoriteViewController()
        let nav2 = UINavigationController(rootViewController: favorite)
        nav2.tabBarItem = UITabBarItem(title: "관심 게시글", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        let profile = ProfileViewController()
        let nav3 = UINavigationController(rootViewController: profile)
        nav3.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person.fill"), tag: 2)
        
        setViewControllers([nav1,nav2,nav3], animated: true)
    }
}
