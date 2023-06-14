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
    
    lazy var stackView = UIStackView(arrangedSubviews: [registerEmail, registerPassword, UIView()], spacing: 12, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 100, left: 12, bottom: 0, right: 12))

    override func viewDidLoad() {
        super.viewDidLoad()

        registerConfigUI()
        buttonConfigUI()
    }
    
    //Config for the register button, email and password.
    
    func registerConfigUI() {
        
        view.addSubview(stackView)
        view.addSubview(registerButton)
        
        view.backgroundColor = UIColor(named: backgroundColor)
        
        navigationController?.navigationBar.tintColor = .black
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerPassword.snp.bottom).offset(250)
            make.width.equalTo(350)
            make.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalToSuperview().inset(12)
        }
        
        registerEmail.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        registerPassword.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerEmail.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
    }
    
    func buttonConfigUI() {
        
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)]
        let emailAttributedTextField = NSAttributedString(string: registerEmail.placeholder ?? "E-mail", attributes: attributes)
        let passwordAttributedTextField = NSAttributedString(string: registerPassword.placeholder ?? "Password", attributes: attributes)
        
        registerButton.setTitle("CREATE AN ACCOUNT", for: .normal)
        registerButton.backgroundColor = .black
        registerButton.layer.cornerRadius = 20
        registerButton.tintColor = .black
        registerButton.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerEmail.placeholder = "E-mail"
        registerEmail.attributedPlaceholder = emailAttributedTextField
        registerEmail.backgroundColor = UIColor(named: textFieldColor)
        registerEmail.borderStyle = .roundedRect
        registerEmail.tintColor = .black
        registerEmail.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        
        registerPassword.placeholder = "Password"
        registerPassword.attributedPlaceholder = passwordAttributedTextField
        registerPassword.textColor = .black
        registerPassword.borderStyle = .roundedRect
        registerPassword.backgroundColor = UIColor(named: textFieldColor)
        registerPassword.frame = CGRect(x: 100, y: 150, width: 350, height: 40)
        registerPassword.isSecureTextEntry = true
        
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
