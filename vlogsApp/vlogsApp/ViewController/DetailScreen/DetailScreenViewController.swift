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
    
    var detailScreenView = DetailScreenView()
    var firebaseManager: FirebaseManager?
    weak var delegate: DetailScreenViewControllerDelegate?
    var blog: Blog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailScreenView.delegate = self
        detailScreenView.blog = blog
        
        detailScreenView.titleLabel.text = blog?.title
        detailScreenView.descriptionLabel.text = blog?.description
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonTapped))
        
        view.addSubview(detailScreenView)
        
        detailScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        firebaseManager?.downloadPhoto(path: detailScreenView.blog?.image ?? "", completion: { url in
            self.detailScreenView.vlogImageView.sd_setImage(with: url)
        })
        
    }
    
    init(firebaseManager: FirebaseManager?, blog: Blog) {
        self.blog = blog
        self.firebaseManager = firebaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -

extension DetailScreenViewController: DetailScreenProtocol {
    
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
                
        
                if let title = self.detailScreenView.blog?.title, let description = self.detailScreenView.blog?.description, let blogID = self.detailScreenView.blog?.blogID {
                    self.firebaseManager?.updateBlogData(blogID: blogID, title: title, description: description, newTitle: newTitle, newDescription: newDescription, completion: { error in
                        if let error = error {
                            print("Error updating \(error)")
                        } else {
                            self.detailScreenView.blog?.title = newTitle
                            self.detailScreenView.blog?.description = newDescription
                            
                            self.detailScreenView.titleLabel.text = newTitle
                            self.detailScreenView.descriptionLabel.text = newDescription
                            
                            guard let selectedBlog = self.detailScreenView.blog else {
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
