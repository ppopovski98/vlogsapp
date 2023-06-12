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
        view.backgroundColor = .green
    }
    
    func configUI() {
        title = "Profile"        
    }

}
