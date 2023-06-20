//
//  DetailScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit
import SnapKit

class DetailScreenViewController: UIViewController {
    
    
    let vlogImageView = UIImageView()
    var imageEnlarged: UIImage?
    weak var delegate: AddABlogDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
        view.addSubview(vlogImageView)
        
        view.backgroundColor = UIColor(named: "backgroundColor")

        vlogImageView.contentMode = .scaleAspectFit
        vlogImageView.clipsToBounds = true
        
        vlogImageView.layer.cornerRadius = 20
        vlogImageView.layer.borderWidth = 1
        
        vlogImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(350)
            make.height.equalTo(250)
        }
        
    }
}

extension DetailScreenViewController: AddABlogDelegate {
    func addBlog(_ blog: AddABlogModel, image: UIImage) {
        vlogImageView.image = image

    }
}
