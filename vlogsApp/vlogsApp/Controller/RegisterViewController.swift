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
    
    let registerEmail = UITextField()
    let registerPassword = UITextField()
    let registerButton = UIButton()
    
    let textFieldColor = "textFieldColor"
    let backgroundColor = "backgroundColor"

    override func viewDidLoad() {
        super.viewDidLoad()

        registerConfigUI()
    }
    
    //Config for the register button, email and password.
    
    func registerConfigUI() {
        
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)]
        let emailAttributedTextField = NSAttributedString(string: registerEmail.placeholder ?? "E-mail", attributes: attributes)
        let passwordAttributedTextField = NSAttributedString(string: registerPassword.placeholder ?? "Password", attributes: attributes)
        
        view.backgroundColor = UIColor(named: backgroundColor)
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(named: textFieldColor)
        registerButton.layer.cornerRadius = 10
        registerButton.tintColor = .white
        registerButton.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        
        registerEmail.placeholder = "E-mail"
        registerEmail.attributedPlaceholder = emailAttributedTextField
        registerEmail.backgroundColor = UIColor(named: textFieldColor)
        registerEmail.borderStyle = .roundedRect
        registerEmail.tintColor = .white
        registerEmail.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        view.addSubview(registerEmail)
        
        registerPassword.placeholder = "Password"
        registerPassword.attributedPlaceholder = passwordAttributedTextField
        registerPassword.textColor = .white
        registerPassword.borderStyle = .roundedRect
        registerPassword.backgroundColor = UIColor(named: textFieldColor)
        registerPassword.frame = CGRect(x: 100, y: 150, width: 350, height: 40)
        registerPassword.isSecureTextEntry = true
        view.addSubview(registerPassword)
        
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerPassword.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        registerEmail.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registerPassword.snp.top).offset(-10)
            make.width.equalTo(350)
            make.height.equalTo(40)
        }
        
        registerPassword.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(40)
        }
    }
    
    @objc func registerButtonTapped() {
        guard let email = registerEmail.text, !email.isEmpty,
              let password = registerPassword.text, !password.isEmpty else {
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error.")
            } else {
                print("Success.")
            }
        }
    }

}
