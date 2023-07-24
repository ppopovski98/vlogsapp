//
//  MainScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class RacingScreenViewController: BaseUiNavigationBarAppearance, UIScrollViewDelegate {
    
    var firebaseManager: FirebaseManager?
    
    lazy var dataSource: [Blog] = []
    var category = "racing"
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScreenConfigUI()
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        firebaseManager?.getDataFromFirebase(completion: { dataSourceForTableView in
            self.dataSource = dataSourceForTableView
            self.collectionView.reloadData()
        })
    }
    
    func mainScreenConfigUI() {
        
        title = "Racing"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
        
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

extension RacingScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as? BlogCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let blog = dataSource[indexPath.item]
        
        firebaseManager?.dowloadPhoto(path: blog.image, completion: { imageData in
            cell.postImageView.image = UIImage(data: imageData)
        })
        
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
            let detailVC = DetailScreenViewController(firebaseManager: FirebaseManager())
            detailVC.blog = selectedBlog
            detailVC.delegate = self
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: -

extension RacingScreenViewController: BlogCollectionViewCellDelegate {    
    
    func didTapFavouritesButton(blog: Blog) {
        
        guard let firebaseManager = firebaseManager else { return }
    
        var updatedBlog = blog
        updatedBlog.isFavourite.toggle()
        
        firebaseManager.uploadData(title: updatedBlog.title,
                                    description: updatedBlog.description,
                                    image: updatedBlog.image,
                                    isFavourite: updatedBlog.isFavourite,
                                    category: updatedBlog.category,
                                    timestamp: updatedBlog.timestamp ) { success in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
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
            dataSource.insert(blog, at: 0)
            collectionView.reloadData()
        }
    }
}

extension RacingScreenViewController: DetailScreenViewControllerDelegate {
    func didUpdateBlog(_ blog: Blog) {
        if let index = dataSource.firstIndex(where: { $0.image == blog.image }) {
            dataSource[index] = blog
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        }
    }
}

