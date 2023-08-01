//
//  DetailScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit
import SnapKit
import SDWebImage

protocol DetailScreenViewControllerDelegate: AnyObject {
    func didUpdateBlog(_ blog: Blog)
}

class DetailScreenViewController: UIViewController {
    
    var firebaseManager: FirebaseManager?
    weak var delegate: DetailScreenViewControllerDelegate?
    var blog: Blog?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = blog?.title
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = blog?.description
        return label
    }()
    
    lazy var vlogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var vlogImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager?.dowloadPhoto(path: blog?.image ?? "", completion: { url in
            self.vlogImageView.sd_setImage(with: url)
        })
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        configUI()
    }
    
    init(firebaseManager: FirebaseManager?) {
        self.firebaseManager = firebaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonTapped))

        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(vlogImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(vlogImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        vlogImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(350)
            make.height.equalTo(250)
        }
    }
    
    @objc func editButtonTapped() {
        
        let alertController = UIAlertController(title: "Edit Blog", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter New Title"
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter New Description"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let newTitle = alertController.textFields?[0].text,
               let newDescription = alertController.textFields?[1].text {
                
        
                if let title = self.blog?.title, let description = self.blog?.description, let blogID = self.blog?.blogID {
                    self.firebaseManager?.updateBlogData(blogID: blogID, title: title, description: description, newTitle: newTitle, newDescription: newDescription, completion: { error in
                        if let error = error {
                            print("Error updating \(error)")
                        } else {
                            self.blog?.title = newTitle
                            self.blog?.description = newDescription
                            
                            self.titleLabel.text = newTitle
                            self.descriptionLabel.text = newDescription
                            
                            guard let selectedBlog = self.blog else {
                                return
                            }
                            self.delegate?.didUpdateBlog(selectedBlog)
                            print("Blog updated successfully.")
                        }
                    })
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

