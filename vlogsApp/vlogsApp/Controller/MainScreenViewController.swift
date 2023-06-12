//
//  MainScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import FirebaseFirestore

class MainScreenViewController: UIViewController {
    
    var blogs: [String] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        mainScreenConfigUI()
    }
    
    func mainScreenConfigUI() {
            
        title = "Blogs"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.setHidesBackButton(true, animated: true)

        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }
    
    @objc func addButtonTapped() {
        navigationController?.pushViewController(AddABlogViewController(), animated: true)
        if let tabBarVC = tabBarController as? TabBarViewController {
                    tabBarVC.tabBar.isHidden = true
                }
    }
    
    @objc func alertButtonTapped() {
        navigationController?.pushViewController(AlertScreenViewController(), animated: true)
        if let tabBarVC = tabBarController as? TabBarViewController {
                    tabBarVC.tabBar.isHidden = true
                }
    }

}

//MARK: -

extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailScreenViewController(), animated: true)
    }
    
}
