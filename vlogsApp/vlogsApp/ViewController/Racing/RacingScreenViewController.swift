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
        
        title = "Racing"
        
        view.addSubview(racingView)
        
        racingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        racingView.collectionView.dataSource = self
        racingView.collectionView.delegate = self
        
        guard let blog = self.blog else {
            return
        }
        
        didUpdateBlog(blog, racingView.collectionView)
        addBlog(blog, image: nil, racingView.collectionView)
        
//        longPressDelete(collectionView: racingScreenView.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromFirebase(category: "racing", collectionView: racingView.collectionView)
    }
    
//    override func longPressDelete() {
//        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(popUpActionCell(longPressGesture:)))
//        lpgr.minimumPressDuration = 0.5
//        lpgr.delaysTouchesBegan = true
//        lpgr.delegate = self
//        self.racingScreenView.collectionView.addGestureRecognizer(lpgr)
//    }
}

