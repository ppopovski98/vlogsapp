//
//  RacingScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class RacingScreenViewController: BaseUiNavigationBarAppearance, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var firebaseManager: FirebaseManager?
    var racingScreenView = RacingScreenView()
    
    lazy var dataSource: [Blog] = []
    lazy var category = "racing"
    lazy var isFirstAppearence = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Racing"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(racingScreenView)
        
        racingScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        racingScreenView.collectionView.dataSource = self
        racingScreenView.collectionView.delegate = self
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(popUpActionCell(longPressGesture:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        racingScreenView.collectionView.addGestureRecognizer(lpgr)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let firebaseManager = firebaseManager else {
            return
        }
        
        firebaseManager.getDataFromFirebase(forCategory: "racing", completion: { dataSourceForTableView, success  in
            self.dataSource = dataSourceForTableView
            self.racingScreenView.collectionView.reloadData()
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
    
    @objc func popUpActionCell(longPressGesture : UILongPressGestureRecognizer) {
        
        let point = longPressGesture.location(in: racingScreenView.collectionView)
        let indexPath = racingScreenView.collectionView.indexPathForItem(at: point)
        
        
        
        if let indexPath = indexPath
        {
            
            guard let firebaseManager = firebaseManager else {
                return
            }
            
            let alertActionCell = UIAlertController(title: "Delete vlog?", message: "Choose an action for the selected vlog", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                let itemToDelete = self.dataSource[indexPath.row]
                
                firebaseManager.deleteBlogData(documentID: itemToDelete.blogID ?? "") { error in
                    if let error = error {
                        print("Error deleting document. \(error)")
                    } else {
                        print("Document deleted.")
                        self.dataSource.remove(at: indexPath.row)
                        self.racingScreenView.collectionView.reloadData()
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
    
}

//MARK: -

extension RacingScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        if let cell = collectionView.cellForItem(at: indexPath) as? BlogCollectionViewCell {
            let detailVC = DetailScreenViewController(firebaseManager: firebaseManager, blog: dataSource[indexPath.item])
            detailVC.detailScreenView.blog = selectedBlog
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: -

extension RacingScreenViewController: BlogCollectionViewCellDelegate {
    
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
                    self.racingScreenView.collectionView.reloadData()
                }
            } else {
                print("Failure")
            }
        }
    }
}

extension RacingScreenViewController: AddABlogDelegate {
    func addBlog(_ blog: Blog, image: UIImage) {
        if blog.category == "racing" {
            DispatchQueue.main.async {
                self.dataSource.insert(blog, at: 0)
                self.racingScreenView.collectionView.reloadData()
            }
        }
    }
}

extension RacingScreenViewController: DetailScreenViewControllerDelegate {
    func didUpdateBlog(_ blog: Blog) {
        if let index = dataSource.firstIndex(where: { $0.image == blog.image }) {
            dataSource[index] = blog
            self.racingScreenView.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        }
    }
}

