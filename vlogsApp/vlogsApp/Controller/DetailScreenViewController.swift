//
//  DetailScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit
import SnapKit

class DetailScreenViewController: UIViewController {
    
    var blogTitle: String!
    var blogDescription: String!
    var blogImage = UIImage()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let vlogImageView = UIImageView()
    weak var delegate: AddABlogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
        titleLabel.text = blogTitle
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        descriptionLabel.text = blogDescription
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(vlogImageView)
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        vlogImageView.image = blogImage
        vlogImageView.contentMode = .scaleToFill
        vlogImageView.clipsToBounds = true
        vlogImageView.layer.cornerRadius = 20
        vlogImageView.layer.borderWidth = 1
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(vlogImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(12)
        }
            vlogImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(20)
                make.width.equalTo(350)
                make.height.equalTo(250)
            }
        }
    }

