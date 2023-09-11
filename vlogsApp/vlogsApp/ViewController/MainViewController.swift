//
//  MainViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 6.9.23.
//

import UIKit
import SnapKit
import SDWebImage

class MainViewController: BaseUiNavigationBarAppearance, UIScrollViewDelegate, UIGestureRecognizerDelegate, AddABlogDelegate, DetailScreenViewControllerDelegate {
    
    
    var firebaseManager: FirebaseManager?
    var gamingView = GamingScreenView()
    var racingView = RacingScreenView()
    
    lazy var dataSource: [Blog] = []
    lazy var isFirstAppearence = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func longPressDelete(for collectionView: UICollectionView) {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(popUpActionCell(longPressGesture:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        collectionView.addGestureRecognizer(lpgr)
    }
    
    func getDataFromFirebase(category: String, collectionView: UICollectionView) {
        
        guard let firebaseManager = firebaseManager else {
            return
        }
        
        firebaseManager.getDataFromFirebase(forCategory: category, completion: { dataSourceForTableView, success  in
            self.dataSource = dataSourceForTableView
            collectionView.reloadData()
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
    
    @objc func popUpActionCell(longPressGesture: UILongPressGestureRecognizer) {
        
        guard let collectionView = longPressGesture.view as? UICollectionView else { return }
        
        let point = longPressGesture.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: point)
        
        if let indexPath = indexPath
        {
            
            guard let firebaseManager = firebaseManager else {
                return
            }
            
            guard let blogID = self.dataSource[indexPath.row].blogID else {
                print("Cannot find blog ID.")
                return
            }
            
            let alertActionCell = UIAlertController(title: "Delete vlog?", message: "Choose an action for the selected vlog", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                
                firebaseManager.deleteBlogData(documentID: blogID) { error in
                    if let error = error {
                        print("Error deleting document. \(error)")
                    } else {
                        print("Document deleted.")
                        self.dataSource.remove(at: indexPath.row)
                        collectionView.reloadData()
                    }
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { acion in
                print("Cancel actionsheet")
            })
            
            alertActionCell.addAction(deleteAction)
            alertActionCell.addAction(cancelAction)
            self.present(alertActionCell, animated: true, completion: nil)
        }
    }
    
    init(firebaseManager: FirebaseManager) {
        
        self.firebaseManager = firebaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBlog(_ blog: Blog, image: UIImage?, _ collectionView: UICollectionView?) {
        guard let collectionView = collectionView else {
            return
        }
        if blog.category == "gaming" {
            DispatchQueue.main.async {
                self.dataSource.insert(blog, at: 0)
                collectionView.reloadData()
            }
        }
    }
    
    func didUpdateBlog(_ blog: Blog, _ collectionView: UICollectionView?) {
        guard let collectionView = collectionView else {
            return
        }
        if let index = dataSource.firstIndex(where: { $0.image == blog.image }) {
            dataSource[index] = blog
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        }
    }
}

//MARK: -

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as? BlogCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let blog = dataSource[indexPath.item]
        cell.dataSource = blog
        cell.firebaseManager = firebaseManager
        cell.updateCell(with: blog)
        
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
            let detailVC = DetailScreenViewController(firebaseManager: firebaseManager, blog: dataSource[indexPath.item])
            detailVC.detailScreenView.blog = selectedBlog
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: -

extension MainViewController: BlogCollectionViewCellDelegate {
    
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

