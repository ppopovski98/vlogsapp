//
//  GamingScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class GamingScreenViewController: MainViewController {
    
    var blog: Blog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gaming"
        
        view.addSubview(gamingView)
        
        gamingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gamingView.collectionView.dataSource = self
        gamingView.collectionView.delegate = self
        
        longPressDelete(for: gamingView.collectionView)
        
        guard let blog = self.blog else {
            return
        }
        
        didUpdateBlog(blog, gamingView.collectionView)
        addBlog(blog, image: nil, gamingView.collectionView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromFirebase(category: "gaming", collectionView: gamingView.collectionView)
    }
}
