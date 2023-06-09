//
//  TabBarViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 8.6.23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarConfigUI()
    }
    
    func tabBarConfigUI() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tabBar.backgroundColor = .white
        
        let mainScreen = MainScreenViewController()
        let profileScreen = ProfileViewController()
        let favouriteScreen = FavouritesScreenViewController()
            
        profileScreen.title = "Profile"
        favouriteScreen.title = "Favourites"
        
        let mainScreenNavController = UINavigationController(rootViewController: mainScreen)
        
        let viewControllers = [mainScreenNavController, profileScreen, favouriteScreen]
        mainScreenNavController.title = "Main"
        self.setViewControllers(viewControllers, animated: false)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: mainScreen, action: #selector(mainScreen.addButtonTapped))
        mainScreen.navigationItem.rightBarButtonItem = addButton
        mainScreen.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "textFieldColor")
        
        guard let items = tabBar.items else { return }
        let images =  ["house.circle", "person.circle", "star.circle"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}
