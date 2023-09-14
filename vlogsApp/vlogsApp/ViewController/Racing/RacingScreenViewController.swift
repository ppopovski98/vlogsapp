//
//  RacingScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class RacingScreenViewController: MainViewController {
    
    var blog: Blog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "racingTitle".localized()
        
        view.addSubview(racingView)
        
        racingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        racingView.collectionView.dataSource = self
        racingView.collectionView.delegate = self
        
        longPressDelete(for: racingView.collectionView)
        
        guard let blog = self.blog else {
            return
        }
        didUpdateBlog(blog, racingView.collectionView)
        addBlog(blog, image: nil, racingView.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromFirebase(category: "racingCategory".localized(), collectionView: racingView.collectionView)
    }
}

