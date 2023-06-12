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
        
        view.addSubview(blogDescription)
        
        view.backgroundColor = UIColor(named: "backgroundColor")
    }

}
