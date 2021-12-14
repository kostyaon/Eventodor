//
//  BaseTabBarController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupVC()
    }
}

private
extension BaseTabBarController {
    
    func createNavBar(for rootVC: UIViewController, title: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootVC)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        return navController
    }
    
    func setupTabBar() {
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false
        tabBar.barTintColor = .black
        let color = UIColor.white
       
        let fontColor = UIColor(red: 236/256, green: 0.0, blue: 0.0, alpha: 1.0)
        let unselectedColor = UIColor.black
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = color
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: fontColor, .font: UIFont.boldSystemFont(ofSize: 13)]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor, .font: UIFont.systemFont(ofSize: 13)]
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            tabBar.barTintColor = color;
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], for: .normal)
        }
        
        tabBar.tintColor = fontColor
        tabBar.unselectedItemTintColor = unselectedColor
    }
    
    func setupVC() {
        viewControllers = [
            createNavBar(for: LoginViewController(), title: "Event", image: "feed_tab_icon"),
            createNavBar(for: EventsViewController(eventState: .events), title: "Map", image: "score_tab_icon"),
            createNavBar(for: EventsViewController(eventState: .myEvents), title: "My Events", image: "logbook_tab_icon"),
            createNavBar(for: UIViewController(), title: "Profile", image: "bonus_tab_icon"),
            createNavBar(for: AwardsViewController(), title: "Awards", image: "bonus_tab_icon")
        ]
    }
}
