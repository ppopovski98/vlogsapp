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
        
        let mainScreen = RacingScreenViewController(firebaseManager: FirebaseManager())
        let profileScreen = ProfileViewController()
        let favouriteScreen = FavouritesScreenViewController()
        let gamingScreen = GamingScreenViewController(firebaseManager: FirebaseManager())

        profileScreen.title = "Profile"
        favouriteScreen.title = "Favourites"
        gamingScreen.title = "Gaming"
        
        let mainScreenNavController = UINavigationController(rootViewController: mainScreen)
        let profileScreenNavController = UINavigationController(rootViewController: profileScreen)
        let favouriteScreenNavController = UINavigationController(rootViewController: favouriteScreen)
        let gamingScreenNavController = UINavigationController(rootViewController: gamingScreen)
        
        let viewControllers = [profileScreenNavController, gamingScreenNavController, mainScreenNavController, favouriteScreenNavController]
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
        let images =  ["person.circle", "theatermasks.circle", "flag.checkered.circle", "star.circle"]
                
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}
