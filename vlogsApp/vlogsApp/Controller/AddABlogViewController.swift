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
    
    lazy var imageView = UIImageView()
    var selectedImage: UIImage?
    var selectedImageURL: String?
    var selectedDate: Date?
    var selectedCategory: String = "racing"
    
    lazy var photoPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.setTitle("UPLOAD A PHOTO", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        
        button.addTarget(self, action: #selector(photoPickerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var titleTextField: UITextField = {
        let title = UITextField()
        title.backgroundColor = .white
        title.textColor = .black
        title.layer.cornerRadius = 10
        return title
    }()
    
    lazy var descritptionTextField: UITextField = {
        let title = UITextField()
        title.backgroundColor = .white
        title.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        title.textColor = .black
        title.layer.cornerRadius = 10
        return title
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        button.setTitle("POST", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerValueChange), for: .valueChanged)
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    lazy var categorySwitch: UISwitch = {
       let uiSwitch = UISwitch()
        uiSwitch.addTarget(self, action: #selector(categorySwitchValue), for: .valueChanged)
        return uiSwitch
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleTextField, descritptionTextField, UIView()], spacing: 12, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 100, left: 12, bottom: 0, right: 12))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = false
        }
    }
    
    @objc func postButtonTapped() {
        
        guard let title = titleTextField.text,
                  let description = descritptionTextField.text,
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
    
    func configUI() {
        
        title = "New Blog"
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(stackView)
        view.addSubview(postButton)
        view.addSubview(photoPickerButton)
        view.addSubview(imageView)
        view.addSubview(datePicker)
        view.addSubview(categorySwitch)
        
        photoPickerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleTextField.snp.top).offset(-10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        postButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(categorySwitch.snp.bottom).offset(12)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        descritptionTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(85)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descritptionTextField.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(250)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descritptionTextField.snp.bottom).offset(20)
        }
        categorySwitch.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
    }
    
    @objc func datePickerValueChange() {
        selectedDate = datePicker.date
        
        if let selectedDate = selectedDate {
            lazy var formattedDate = dateFormatter.string(from: selectedDate)
        } else {
            return
        }
    }
    
    @objc func photoPickerButtonTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func retrievePhotos() {
        let fileRef = Storage.storage().reference(withPath: "Posts/\(UUID().uuidString).jpg")
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    @objc func categorySwitchValue() {
        selectedCategory = categorySwitch.isOn ? "gaming" : "racing"
    }
}

extension AddABlogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
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
