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
        
        let vlogImage = UIImage(systemName: "bell")
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tabBar.backgroundColor = .white
        
        let mainScreen = MainScreenViewController()
        let profileScreen = ProfileViewController()
        let favouriteScreen = FavouritesScreenViewController()
            
        profileScreen.title = "Profile"
        favouriteScreen.title = "Favourites"
        
        let mainScreenNavController = UINavigationController(rootViewController: mainScreen)
        
        let viewControllers = [profileScreen, mainScreenNavController, favouriteScreen]
        mainScreenNavController.title = "Main"
        self.setViewControllers(viewControllers, animated: false)
        self.selectedViewController = mainScreenNavController
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: mainScreen, action: #selector(mainScreen.addButtonTapped))
        mainScreen.navigationItem.rightBarButtonItem = addButton
        mainScreen.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "textFieldColor")
        
        let alertButton = UIBarButtonItem(image: vlogImage, style: .done, target: mainScreen, action: #selector(mainScreen.alertButtonTapped))
        mainScreen.navigationItem.leftBarButtonItem = alertButton
        mainScreen.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "textFieldColor")
        
        guard let items = tabBar.items else { return }
        let images =  ["person.circle", "house.circle", "star.circle"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}
