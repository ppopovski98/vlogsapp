//
//  TabBarViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 8.6.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let mainScreen = RacingScreenViewController(firebaseManager: FirebaseManager())
    let profileScreen = ProfileViewController()
    let favouriteScreen = FavouritesScreenViewController(firebaseManager: FirebaseManager())
    let gamingScreen = GamingScreenViewController(firebaseManager: FirebaseManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.barTintColor = .white
        tabBarController?.tabBar.tintColor = .white
        addAndAlert()
        tabBarConfigUI()
    }
    
    func tabBarConfigUI() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tabBar.backgroundColor = .white
        
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
        
        guard let items = tabBar.items else { return }
        let images =  ["person.circle", "theatermasks.circle", "flag.checkered.circle", "star.circle"]
                
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
    
    func addAndAlert() {
        
        let vlogImage = UIImage(systemName: "bell")
        
        let mainScreenAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: mainScreen, action: #selector(mainScreen.addButtonTapped))
        mainScreen.navigationItem.rightBarButtonItem = mainScreenAddButton
        mainScreen.navigationItem.rightBarButtonItem?.tintColor = .black
        
        let mainScreenAlertButton = UIBarButtonItem(image: vlogImage, style: .done, target: mainScreen, action: #selector(mainScreen.alertButtonTapped))
        mainScreen.navigationItem.leftBarButtonItem = mainScreenAlertButton
        mainScreen.navigationItem.leftBarButtonItem?.tintColor = .black
        
        let gamingScreenAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: gamingScreen, action: #selector(gamingScreen.addButtonTapped))
        gamingScreen.navigationItem.rightBarButtonItem = gamingScreenAddButton
        gamingScreen.navigationItem.rightBarButtonItem?.tintColor = .black
        
        let gamingScreeenAlertButton = UIBarButtonItem(image: vlogImage, style: .done, target: gamingScreen, action: #selector(gamingScreen.alertButtonTapped))
        gamingScreen.navigationItem.leftBarButtonItem = gamingScreeenAlertButton
        gamingScreen.navigationItem.leftBarButtonItem?.tintColor = .black
    }
}
