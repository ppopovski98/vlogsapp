//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 8.6.23.
//
//Scrollview
import UIKit
import SnapKit

class AddABlogViewController: UIViewController {
    
    lazy var titleTextField: UITextField = {
        let title = UITextField()
        title.backgroundColor = UIColor(named: "textFieldColor")
        title.textColor = .white
        title.layer.cornerRadius = 10
        return title
    }()
    
    lazy var descritptionTextField: UITextField = {
        let title = UITextField()
        title.backgroundColor = UIColor(named: "textFieldColor")
        title.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        title.textColor = .white
        title.layer.cornerRadius = 10
        return title
    }()
    
    let postButton = UIButton()
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
    
    func configUI() {
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(stackView)
        view.addSubview(postButton)
        
        
        postButton.backgroundColor = UIColor(named: "textFieldColor")
        postButton.setTitle("Post", for: .normal)
        postButton.tintColor = .white
        postButton.layer.cornerRadius = 10
        
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
        }
        
        descritptionTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(85)
        }
    }
}