//
//  RacingScreenView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

class RacingScreenView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        return collectionView
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    lazy var placeholderImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    override init (frame: CGRect) {
        super.init(frame: .zero)
        mainScreenConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mainScreenConfigUI() {
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        addSubview(collectionView)
        addSubview(activityIndicatorView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
                
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
