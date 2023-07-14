//
//  DetailScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class DetailScreenViewController: UIViewController {
    
    var firebaseManager: FirebaseManager?
    
    var blog: Blog?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = blog?.title
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = blog?.description
        return label
    }()
    
    lazy var vlogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var vlogImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager?.dowloadPhoto(path: blog?.image ?? "", completion: { imageData in
            self.vlogImageView.image = UIImage(data: imageData)
        })
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        configUI()
    }
    
    init(firebaseManager: FirebaseManager?) {
        self.firebaseManager = firebaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(vlogImageView)
        
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

