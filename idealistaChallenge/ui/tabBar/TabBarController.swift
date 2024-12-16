//
//  TabBarController.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        doFetchViewControllers()
    }
    
    func styleView() {
        self.tabBar.barTintColor = .white
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func doFetchViewControllers() {
        viewControllers = doBuildViewControllers()
    }
    
    func doBuildViewControllers() -> [UIViewController] {
        let listNavController = doBuildListNavigationController()
        let settingsNavController = doBuildSettingsNavigationController()
        return [listNavController, settingsNavController]
    }
    
    private func doBuildListNavigationController() -> UINavigationController {
        let listNavigationController = ListViewController().embedInUINavigationController()
        let listTabBarItem = UITabBarItem(title: "Lista", image: UIImage(systemName: "map"), tag: 0)
        listNavigationController.tabBarItem = listTabBarItem
        return listNavigationController
    }
    
    private func doBuildSettingsNavigationController() -> UINavigationController {
        let settingsNavigationController = SettingsViewController().embedInUINavigationController()
        let settingsTabBarItem = UITabBarItem(title: "Actuaciones", image:  UIImage(systemName: "map"), tag: 1)
        settingsNavigationController.tabBarItem = settingsTabBarItem
        return settingsNavigationController
    }
 
}

