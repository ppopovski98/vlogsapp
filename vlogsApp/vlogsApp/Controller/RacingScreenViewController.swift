//
//  MainScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SDWebImage

class RacingScreenViewController: UIViewController, UIScrollViewDelegate {
    
    var firebaseManager: FirebaseManager?
    
    lazy var dataSource: [Blog] = []
    
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
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
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
        
        cell.titleLabel.text = blog.title
        cell.descriptionLabel.text = blog.description
        
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
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension RacingScreenViewController: BlogCollectionViewCellDelegate {
    
    func didTapFavouritesButton(cell: BlogCollectionViewCell, indexPath: IndexPath, isFavourite: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        guard let firebaseManager = firebaseManager else { return }
        
        let selectedBlog = dataSource[indexPath.item]
        
        
        firebaseManager.uploadPhoto(title: selectedBlog.title,
                                    description: selectedBlog.description,
                                    image: selectedBlog.image,
                                    isFavourite: isFavourite) { success in
            if success {
                self.dataSource[indexPath.item] .isFavourite = isFavourite
                self.collectionView.reloadData()
            } else {
                print("Failure")
            }
        }
    }
}

extension RacingScreenViewController: AddABlogDelegate {
    
    func addBlog(_ blog: Blog, image: UIImage) {
        dataSource.insert(blog, at: 0)
    }
}
