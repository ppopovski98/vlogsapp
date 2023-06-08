//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit

class FavouritesScreenViewController: UIViewController {
    
    let blogDescription = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        view.addSubview(blogDescription)
    }

}
