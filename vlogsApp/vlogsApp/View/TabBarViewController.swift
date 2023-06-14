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
    
        navigationController?.navigationBar.barTintColor = .white
        tabBarController?.tabBar.tintColor = .white
        tabBarConfigUI()
    }
    
    func tabBarConfigUI() {
        
        let vlogImage = UIImage(systemName: "bell")
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tabBar.backgroundColor = .white
        
        let mainScreen = MainScreenViewController()
        let profileScreen = ProfileViewController()
        let favouriteScreen = FavouritesScreenViewController()
            
        profileScreen.title = "Profile"
        favouriteScreen.title = "Favourites"
        
        let mainScreenNavController = UINavigationController(rootViewController: mainScreen)
        let profileScreenNavController = UINavigationController(rootViewController: profileScreen)
        let favouriteScreenNavController = UINavigationController(rootViewController: favouriteScreen)
        
        let viewControllers = [profileScreenNavController, mainScreenNavController, favouriteScreenNavController]
        mainScreenNavController.title = "Main"
        self.setViewControllers(viewControllers, animated: false)
        self.selectedViewController = mainScreenNavController
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: mainScreen, action: #selector(mainScreen.addButtonTapped))
        mainScreen.navigationItem.rightBarButtonItem = addButton
        mainScreen.navigationItem.rightBarButtonItem?.tintColor = .black
        
        let alertButton = UIBarButtonItem(image: vlogImage, style: .done, target: mainScreen, action: #selector(mainScreen.alertButtonTapped))
        mainScreen.navigationItem.leftBarButtonItem = alertButton
        mainScreen.navigationItem.leftBarButtonItem?.tintColor = .black
        
        guard let items = tabBar.items else { return }
        let images =  ["person.circle", "house.circle", "star.circle"]
                
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}
