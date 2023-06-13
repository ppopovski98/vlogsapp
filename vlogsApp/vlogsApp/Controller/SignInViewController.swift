//
//  ViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 1.6.23.
//

import UIKit
import FirebaseAuth
import SnapKit

class SignInViewController: UIViewController {
    
    let loginButton = UIButton(type: .roundedRect)
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let noCredentialsAlert = UILabel()
    let registerButton = UIButton(type: .roundedRect)
    
    let emailPlaceholder = UILabel()
    let passwordPlaceholder = UILabel()
    
    let backgroundColor = "backgroundColor"
    let textFieldColor = "textFieldColor"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    
    //Config for the buttons, style and colors.
    
    func configUI() {
        
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)]
        let emailAttributedTextField = NSAttributedString(string: emailTextField.placeholder ?? "Enter E-mail", attributes: attributes)
        let passwordAttributedTextField = NSAttributedString(string: passwordTextField.placeholder ?? "Enter Password", attributes: attributes)
        
        view.backgroundColor = UIColor(named: backgroundColor)
        
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = UIColor(named: textFieldColor)
        loginButton.layer.cornerRadius = 10
        loginButton.tintColor = .white
        loginButton.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(named: textFieldColor)
        registerButton.layer.cornerRadius = 10
        registerButton.tintColor = .white
        registerButton.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        
        emailTextField.frame = CGRect(x: 100, y: 100, width: 350, height: 40)
        emailTextField.placeholder = "Enter E-mail"
        emailTextField.attributedPlaceholder = emailAttributedTextField
        emailTextField.textColor = .white
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = UIColor(named: textFieldColor)
        view.addSubview(emailTextField)
        
        passwordTextField.frame = CGRect(x: 100, y: 150, width: 350, height: 40)
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.attributedPlaceholder = passwordAttributedTextField
        passwordTextField.textColor = .white
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = UIColor(named: textFieldColor)
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        noCredentialsAlert.isHidden = true
        noCredentialsAlert.textColor = .red
        noCredentialsAlert.text = "Please enter an email and/or password."
        noCredentialsAlert.textAlignment = .center
        view.addSubview(noCredentialsAlert)
        
        emailPlaceholder.text = "E-mail"
        emailPlaceholder.textColor = .gray
        view.addSubview(emailPlaceholder)
        
        passwordPlaceholder.text = "Password"
        passwordPlaceholder.textColor = .gray
        view.addSubview(passwordPlaceholder)
        
        // These are the constraints for the mail, password and log in button using snapkit.
        
        passwordPlaceholder.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        emailPlaceholder.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailTextField.snp.top).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(200)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(-50)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.equalTo(passwordPlaceholder.snp.bottom)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        noCredentialsAlert.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
    }
    
    //Firebase Auth
    
    @objc func registerButtonTapped() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func buttonTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            self.startTimer()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
            
        if error != nil {
                self.alertMessage()
                print(error?.localizedDescription ?? "Error")
            } else {
                let tabBarViewController = TabBarViewController()
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
                print("Success")
            }
        })
    }
    
    //Timer and alert message for no credentials.
    
    func startTimer() {
        
        noCredentialsAlert.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false ) { [weak self] timer in
            self?.noCredentialsAlert.isHidden = true
            timer.invalidate()
        }
    }
    
    func alertMessage() {
        
        let alert = UIAlertController(title: "No account with these credentials.", message: "Please create or sign in with an existing account.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


