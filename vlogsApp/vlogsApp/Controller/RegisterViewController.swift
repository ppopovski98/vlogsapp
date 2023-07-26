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
    
    let enterEmailLabel = UILabel()
    let enterPasswordLabel = UILabel()
    
    let textFieldColor = "textFieldColor"
    let backgroundColor = "backgroundColor"
    
    lazy var stackView = UIStackView(arrangedSubviews: [registerEmail, registerPassword, UIView()], spacing: 50, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 100, left: 12, bottom: 0, right: 12))

    override func viewDidLoad() {
        super.viewDidLoad()

        registerConfigUI()
        buttonConfigUI()
    }
    
    //Config for the register button, email and password.
    
    func registerConfigUI() {
        
        view.addSubview(enterEmailLabel)
        view.addSubview(enterPasswordLabel)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        
        view.backgroundColor = UIColor(named: backgroundColor)
        
        navigationController?.navigationBar.tintColor = .black
        
        enterEmailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registerEmail.snp.top).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        enterPasswordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registerPassword.snp.top).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(300)
            make.width.equalTo(350)
            make.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        registerEmail.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        
        registerPassword.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
    }
    
    func buttonConfigUI() {
        
        let emailPaddingView = UIView(frame: CGRectMake(0, 0, 15, self.registerEmail.frame.height))
        registerEmail.leftView = emailPaddingView
        registerEmail.leftViewMode = UITextField.ViewMode.always
        let passwordPaddingView = UIView(frame: CGRectMake(0, 0, 15, self.registerPassword.frame.height))
        registerPassword.leftView = passwordPaddingView
        registerPassword.leftViewMode = UITextField.ViewMode.always
        
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)]
        let emailAttributedTextField = NSAttributedString(string: registerEmail.placeholder ?? "E-mail", attributes: attributes)
        let passwordAttributedTextField = NSAttributedString(string: registerPassword.placeholder ?? "Password", attributes: attributes)
        
        enterEmailLabel.text = "E-mail"
        enterEmailLabel.textColor = .gray
        
        enterPasswordLabel.text = "Password"
        enterPasswordLabel.textColor = .gray
        
        registerButton.setTitle("CREATE AN ACCOUNT", for: .normal)
        registerButton.backgroundColor = .black
        registerButton.layer.cornerRadius = 20
        registerButton.tintColor = .black
        registerButton.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerEmail.placeholder = "E-mail"
        registerEmail.attributedPlaceholder = emailAttributedTextField
        registerEmail.backgroundColor = .white
        registerEmail.layer.cornerRadius = 15
        registerEmail.tintColor = .black
        registerEmail.layer.borderWidth = 0.5
        registerEmail.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        
        registerPassword.placeholder = "Password"
        registerPassword.attributedPlaceholder = passwordAttributedTextField
        registerPassword.textColor = .black
        registerPassword.layer.cornerRadius = 15
        registerPassword.backgroundColor = .white
        registerPassword.layer.borderWidth = 0.5
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
                let tabBarViewController = TabBarViewController()
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
                print("Success.")
            }
        }
    }

}
