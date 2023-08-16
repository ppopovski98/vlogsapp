//
//  GamingScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class GamingScreenViewController: BaseUiNavigationBarAppearance, UIScrollViewDelegate {
    
    var firebaseManager: FirebaseManager?
    var gamingView = GamingScreenView()
    
    lazy var dataSource: [Blog] = []
    lazy var category = "gaming"
    lazy var isFirstAppearence = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gaming"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(gamingView)
        
        gamingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gamingView.collectionView.dataSource = self
        gamingView.collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let firebaseManager = firebaseManager else {
            return
        }
        
        firebaseManager.getDataFromFirebase(forCategory: "gaming", completion: { dataSourceForTableView, success  in
            self.dataSource = dataSourceForTableView
            self.gamingView.collectionView.reloadData()
        })
    }
    
    @objc func addButtonTapped() {
        
        let addBlogVC = AddABlogViewController()
        addBlogVC.delegate = self
        navigationController?.pushViewController(addBlogVC, animated: true)
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = true
        }
    }
    
    @objc func alertButtonTapped() {
        
        navigationController?.pushViewController(NotificationsScreenViewController(), animated: true)
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = true
        }
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

extension GamingScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as? BlogCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let blog = dataSource[indexPath.item]
        cell.dataSource = blog
        cell.updateCell(with: blog)
        
        firebaseManager?.downloadPhoto(path: blog.image ?? "", completion: { url in
            cell.postImageView.sd_setImage(with: url)
        })
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedBlog = dataSource[indexPath.item]
        if collectionView.cellForItem(at: indexPath) is BlogCollectionViewCell {
            let detailVC = DetailScreenViewController(firebaseManager: FirebaseManager())
            detailVC.detailScreenView.blog = selectedBlog
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: -

extension GamingScreenViewController: BlogCollectionViewCellDelegate {
    
    func didTapFavouritesButton(blog: Blog, indexPath: IndexPath) {
        
        guard let firebaseManager = firebaseManager else {
            return
        }
        
        dataSource[indexPath.row].isFavourite.toggle()
        
        var updatedBlog = blog
        updatedBlog.isFavourite.toggle()

        firebaseManager.addToFavourites(updatedBlog) { success in
            if success {
                DispatchQueue.main.async {
                    self.gamingView.collectionView.reloadData()
                }
            } else {
                print("Failure")
            }
        }
    }
}

extension GamingScreenViewController: AddABlogDelegate {
    func addBlog(_ blog: Blog, image: UIImage) {
        if blog.category == "gaming" {
            DispatchQueue.main.async {
                self.dataSource.insert(blog, at: 0)
                self.gamingView.collectionView.reloadData()
            }
        }
    }
}

extension GamingScreenViewController: DetailScreenViewControllerDelegate {
    func didUpdateBlog(_ blog: Blog) {
        if let index = dataSource.firstIndex(where: { $0.image == blog.image }) {
            dataSource[index] = blog
            gamingView.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        }
    }
}

