//
//  NavigationBarAppearance.swift
//  vlogsApp
//
//  Created by Petar Popovski on 14.7.23.
//

import UIKit

class BaseUiNavigationBarAppearance: UIViewController {
    override func viewDidLoad() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "titleColor".localized()) ?? ""]
        
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "titleColor".localized()) ?? ""]
        
        navBarAppearance.backgroundColor = UIColor(named: "background".localized())
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
