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
    lazy var favouriteToggle = true
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseManager?.getDataFromFirebase(completion: { dataSourceForTableView, status in
            if status == true {
                self.selectedBlogs = dataSourceForTableView
                self.filteredBlogs = self.selectedBlogs.filter( { $0.isFavourite } )
                self.collectionView.reloadData()
            } else {
                return
            }
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
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let blog = filteredBlogs[indexPath.item]
        cell.dataSource = blog
        cell.updateCell(with: blog)
        
        firebaseManager?.downloadPhoto(path: filteredBlogs[indexPath.item].image ?? "", completion: { url in
            cell.postImageView.sd_setImage(with: url)
        })
        
        cell.descriptionLabel.text = blog.description
        cell.titleLabel.text = blog.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedBlog = filteredBlogs[indexPath.item]
        if let cell = collectionView.cellForItem(at: indexPath) as? BlogCollectionViewCell {
            let detailVC = DetailScreenViewController(firebaseManager: FirebaseManager())
            detailVC.blog = selectedBlog
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension FavouritesScreenViewController: BlogCollectionViewCellDelegate {
    
    func didTapFavouritesButton(blog: Blog, indexPath: IndexPath) {
        
        guard let firebaseManager = firebaseManager else { return }
        
        var updatedBlog = blog
        updatedBlog.isFavourite = false
        
        firebaseManager.addToFavourites(updatedBlog) { success in
            if success {
                self.collectionView.deleteItems(at: [indexPath])
                self.filteredBlogs.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                print("Failure")
            }
        }
    }
}
