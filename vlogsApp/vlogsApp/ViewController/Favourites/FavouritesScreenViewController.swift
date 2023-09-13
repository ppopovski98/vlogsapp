//
//  FavouritesScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import FirebaseFirestore

class FavouritesScreenViewController: BaseUiNavigationBarAppearance {
    
    let firebaseManager: FirebaseManager?
    var favouritesScreenView = FavouritesScreenView()
    
    lazy var selectedBlogs: [Blog] = []
    lazy var filteredBlogs: [Blog] = []
    lazy var favouriteToggle = true
    lazy var category = "favouritesCategory".localized()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites"
        
        favouritesScreenView.collectionView.backgroundColor = UIColor(named: "background".localized())
        favouritesScreenView.collectionView.dataSource = self
        favouritesScreenView.collectionView.delegate = self
        
        view.addSubview(favouritesScreenView)
        
        favouritesScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseManager?.getDataFromFirebase(completion: { dataSourceForTableView, status in
            if status == true {
                self.selectedBlogs = dataSourceForTableView
                self.filteredBlogs = self.selectedBlogs.filter( { $0.isFavourite } )
                self.favouritesScreenView.collectionView.reloadData()
            } else {
                return
            }
        })
    }

    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -

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
        cell.firebaseManager = firebaseManager
        cell.updateCell(with: blog)
        
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
        if collectionView.cellForItem(at: indexPath) is BlogCollectionViewCell {
            let detailVC = DetailScreenViewController(firebaseManager: firebaseManager, blog: selectedBlog)
            detailVC.detailScreenView.blog = selectedBlog
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: -

extension FavouritesScreenViewController: BlogCollectionViewCellDelegate {
    
    func didTapFavouritesButton(blog: Blog, indexPath: IndexPath) {
        
        guard let firebaseManager = firebaseManager else { return }
        
        var updatedBlog = blog
        updatedBlog.isFavourite = false
        
        firebaseManager.addToFavourites(updatedBlog) { success in
            if success {
                self.filteredBlogs.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.favouritesScreenView.collectionView.reloadData()
                }
            } else {
                print("Failure")
            }
        }
    }
}
