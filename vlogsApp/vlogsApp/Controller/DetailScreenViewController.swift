//
//  DetailScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    let vlogImageView = UIImageView()
    var imageEnlarged: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
        view.backgroundColor = .white

        vlogImageView.image = imageEnlarged
        vlogImageView.contentMode = .scaleAspectFit
        vlogImageView.clipsToBounds = true
        
        vlogImageView.layer.cornerRadius = 20
        vlogImageView.layer.borderWidth = 5
        
    }

}
