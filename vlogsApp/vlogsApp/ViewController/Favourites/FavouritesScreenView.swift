//
//  FavouritesScreenView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

class FavouritesScreenView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init (frame: CGRect) {
        super.init(frame: .zero)
        
        favouritesScreenConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func favouritesScreenConfigUI() {
            
        backgroundColor = UIColor(named: "backgroundColor")

        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
