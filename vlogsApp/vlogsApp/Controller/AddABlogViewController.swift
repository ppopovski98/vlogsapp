//
//  AddABlogViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 8.6.23.
//

import UIKit
import SnapKit

class AddABlogViewController: UIViewController {
    
    let titleTextField = UITextField()
    let descritptionTextField = UITextField()
    let postButton = UIButton()

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
        view.addSubview(titleTextField)
        view.addSubview(descritptionTextField)
        view.addSubview(postButton)
        
        titleTextField.backgroundColor = UIColor(named: "textFieldColor")
        titleTextField.textColor = .white
        titleTextField.layer.cornerRadius = 10

        descritptionTextField.backgroundColor = UIColor(named: "textFieldColor")
        descritptionTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        descritptionTextField.textColor = .white
        descritptionTextField.layer.cornerRadius = 10
        
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
        
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descritptionTextField.snp.top).offset(-10)
            make.width.equalTo(350)
            make.height.equalTo(40)
        }
        
        descritptionTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(350)
            make.height.equalTo(200)
        }
    }
}
