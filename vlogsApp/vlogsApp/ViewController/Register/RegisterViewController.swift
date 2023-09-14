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
        
        navigationController?.navigationBar.tintColor = UIColor(named: "titleColor".localized())

        view.addSubview(registerView)
        registerView.delegate = self
        
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func alertMessage(_ error: String) {
        
        let alert = UIAlertController(title: error, message: "Please enter a valid email and/or password.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
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
                self.alertMessage(error.localizedDescription)
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

