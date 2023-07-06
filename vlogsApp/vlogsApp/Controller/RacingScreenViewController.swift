//
//  MainScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import FirebaseFirestore
import SDWebImage

class RacingScreenViewController: UIViewController, UIScrollViewDelegate {
    
    let firebaseManager: FirebaseManager?
    
    var dataSource: [AddABlogModel] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        return collectionView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    let placeholderImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        mainScreenConfigUI()
        
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
        view.addSubview(activityIndicatorView)
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
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
            let detailVC = DetailScreenViewController()
            detailVC.blogTitle = selectedBlog.title
            detailVC.blogDescription = selectedBlog.description
            detailVC.blogImage = cell.postImageView.image ?? placeholderImage
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension RacingScreenViewController: AddABlogDelegate {
    func addBlog(_ blog: AddABlogModel, image: UIImage) {
        dataSource.insert(blog, at: 0)
    }
}
