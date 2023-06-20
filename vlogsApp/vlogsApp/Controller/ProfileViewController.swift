//
//  ProfileViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        title = "Profile"
        
        view.backgroundColor = UIColor(named: "backgroundColor")

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.white
                
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

}
