//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import FirebaseFirestore

class FavouritesScreenViewController: BaseUiNavigationBarAppearance {
    
    let firebaseManager: FirebaseManager?
    
    lazy var selectedBlogs: [Blog] = []
    lazy var filteredBlogs: [Blog] = []
    lazy var category = "favourites"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        firebaseManager?.getDataFromFirebase(forCategory: "favourites", completion: { dataSourceForTableView in
            self.selectedBlogs = dataSourceForTableView
            self.filteredBlogs = self.selectedBlogs.filter( { $0.isFavourite } )
            self.collectionView.reloadData()
        })
        
        favouritesScreenConfigUI()
    }
    
    func favouritesScreenConfigUI() {
        
        title = "Favourites"
            
        view.backgroundColor = UIColor(named: "backgroundColor")

        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func printing() {
        print("Upgraded base")
    }
}

extension FavouritesScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredBlogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as? BlogCollectionViewCell else {
                return UICollectionViewCell()
            }
        
        let selectedBlog = filteredBlogs[indexPath.item]
        
        firebaseManager?.dowloadPhoto(path: selectedBlog.image) { imageData in
            DispatchQueue.main.async {
                cell.blogCellConfigUI(title: selectedBlog.title, description: selectedBlog.description, image: imageData)
            }
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 300)
    }
}
