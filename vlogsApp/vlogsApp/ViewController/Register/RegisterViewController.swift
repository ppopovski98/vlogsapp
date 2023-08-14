//
//  RegisterViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 6.6.23.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    var registerView = RegisterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(named: "titleColor")

        view.addSubview(registerView)
        registerView.delegate = self
        
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RegisterViewController: RegisterProtocol {
    @objc func registerButtonTapped() {
        
        guard let email = registerView.registerEmail.text, !email.isEmpty,
              let password = registerView.registerPassword.text, !password.isEmpty else {
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let tabBarViewController = TabBarViewController()
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
                print("Success.")
            }
        })
    }
}

