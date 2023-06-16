//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 8.6.23.
//
//Scrollview
import UIKit
import SnapKit

protocol AddABlogDelegate: AnyObject {
    func addBlog(_ blog: Model, image: UIImage)
}

class AddABlogViewController: UIViewController {
    
    weak var delegate: AddABlogDelegate?
    
    lazy var photoPickerButton = UIButton()
    lazy var imageView = UIImageView()
         var selectedImage: UIImage?
    
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
    
    lazy var postButton = UIButton()
    
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
              let image = selectedImage else {
            return
        }
        
        let newBlog = Model(title: title, description: description)
        delegate?.addBlog(newBlog, image: image)
        navigationController?.popViewController(animated: true)
    }
    
    func configUI() {
        
        title = "New Blog"
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(stackView)
        view.addSubview(postButton)
        view.addSubview(photoPickerButton)
        view.addSubview(imageView)
                
        postButton.backgroundColor = UIColor(named: "textFieldColor")
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        postButton.setTitle("POST", for: .normal)
        postButton.tintColor = .black
        postButton.layer.cornerRadius = 20
        
        photoPickerButton.backgroundColor = UIColor(named: "textFieldColor")
        photoPickerButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        photoPickerButton.setTitle("UPLOAD A PHOTO", for: .normal)
        photoPickerButton.tintColor = .black
        photoPickerButton.layer.cornerRadius = 20
        
        photoPickerButton.addTarget(self, action: #selector(photoPickerButtonTapped), for: .touchUpInside)
        
        photoPickerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleTextField.snp.top).offset(-10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        postButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descritptionTextField.snp.bottom).offset(300)
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
    }
    
    @objc func photoPickerButtonTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension AddABlogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
            selectedImage = image
        }
        
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
