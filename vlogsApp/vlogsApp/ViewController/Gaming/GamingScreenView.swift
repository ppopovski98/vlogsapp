//
//  GamingScreenView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

class GamingScreenView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "Background".localized())
        return collectionView
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        mainScreenConfigUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mainScreenConfigUI() {
        
        backgroundColor = UIColor(named: "Background".localized())
        
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
