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

        collectionView.register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        mainScreenConfigUI()
    }
    
    func mainScreenConfigUI() {
        
        view.backgroundColor = .white
            
        self.navigationItem.setHidesBackButton(true, animated: true)

        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        
        collectionView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
            }
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
                
        let tab1 = UIViewController()
        tab1.title = "Tab 1"
        tab1.view.backgroundColor = .red
        
        let tab2 = UIViewController()
        tab1.title = "Tab 2"
        tab1.view.backgroundColor = .green
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([tab1, tab2], animated: false)
        
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = true
        
        navigationController.setViewControllers([self, tabBarController], animated: false)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navigationController
        }

    }
    
    @objc func addButtonTapped() {
        
    }

}

//MARK: -

extension MainScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        return CGSize(width: width, height: 100)
    }
    
}
