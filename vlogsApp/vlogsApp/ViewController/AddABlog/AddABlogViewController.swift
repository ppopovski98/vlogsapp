//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 8.6.23.
//
//Scrollview

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

protocol AddABlogDelegate: AnyObject {
    func addBlog(_ blog: Blog, image: UIImage)
}

class AddABlogViewController: UIViewController {
    
    let db = Firestore.firestore()
    let firebaseManager = FirebaseManager()
    
    weak var delegate: AddABlogDelegate?
    
    var addABlogView = AddABlogView()
    
    var selectedImage: UIImage?
    var selectedImageURL: String?
    var selectedDate: Date?
    var selectedCategory: String = "racing"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Blog"
        
        view.addSubview(addABlogView)
        
        addABlogView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = false
        }
    }
    
    func retrievePhotos() {
        let fileRef = Storage.storage().reference(withPath: "Posts/\(UUID().uuidString).jpg")
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.addABlogView.imageView.image = image
                }
            }
        }
    }
    
    
}

//MARK: -

extension AddABlogViewController: AddABlogProtocol {
    
    @objc func datePickerValueChange() {
        selectedDate = addABlogView.datePicker.date
        
        if let selectedDate = selectedDate {
            lazy var formattedDate = addABlogView.dateFormatter.string(from: selectedDate)
        } else {
            return
        }
    }
    
    @objc func postButtonTapped() {
        
        guard let title = addABlogView.titleTextField.text,
              let description = addABlogView.descritptionTextField.text,
                  let imageURL = selectedImageURL
                   else {
                return
            }
        
        if selectedDate == nil {
            selectedDate = Date()
        }
        
        if let selectedDate = selectedDate {
            firebaseManager.uploadData(title: title, description: description, image: imageURL, isFavourite: false, category: selectedCategory, timestamp: selectedDate.timeIntervalSince1970) { success in
                    if success {
                        guard let selectedImage = self.selectedImage else { return }
                        let newBlog = Blog(title: title, description: description, image: imageURL, isFavourite: false, category: self.selectedCategory, timestamp: self.selectedDate!.timeIntervalSince1970)
                        self.delegate?.addBlog(newBlog, image: selectedImage)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        print("Failed to upload blog.")
                    }
            }
        }
    }
    
    @objc func photoPickerButtonTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func categorySwitchValue() {
        selectedCategory = addABlogView.categorySwitch.isOn ? "gaming" : "racing"
    }
}

//MARK: -

extension AddABlogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            addABlogView.imageView.image = image
            selectedImage = image
            retrievePhotos()
            
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                selectedImageURL = imageData.base64EncodedString()
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
