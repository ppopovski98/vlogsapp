//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit

class FavouritesScreenViewController: UIViewController {
    
    let blogDescription = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesScreenConfigUI()
    }
    
    func favouritesScreenConfigUI() {
        
        title = "Favourites"
            
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.white
                
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        view.addSubview(blogDescription)

    }

}
