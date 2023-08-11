//
//  SignInView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 11.8.23.
//

import UIKit
import SnapKit

protocol SignInProtocol: AnyObject {
    func loginButtonTapped()
    func navigationSomehting()
}

class SignInView: UIView {
    
    weak var delegate: SignInProtocol? = nil

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.text = "test@gmail.com" // WILL REMOVE THIS ( EAZY LOG IN )
        textField.frame = CGRect(x: 100, y: 100, width: 350, height: 40)
        textField.placeholder = "Enter E-mail"
        textField.textColor = .black
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = "asdasdasd" // WILL REMOVE THIS ( EAZY LOG IN )
        textField.frame = CGRect(x: 100, y: 150, width: 350, height: 40)
        textField.placeholder = "Enter Password"
        textField.textColor = .black
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 0.5
        return textField
    }()
    
    lazy var noCredentialsAlert: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.text = "Please enter an email and/or password."
        label.textAlignment = .center
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("CREATE AN ACCOUNT", for: .normal)
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var emailPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textColor = .gray
        return label
    }()
    
    lazy var passwordPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .gray
        return label
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Or Sign Up"
        label.textColor = .gray
        return label
    }()

    
    lazy var lineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var secondLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func registerButtonTapped() {
        delegate?.navigationSomehting()
    }
    
    @objc func loginTapped() {
        self.delegate?.loginButtonTapped()
    }
    
    
    func configUI() {
        
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)]
        let emailAttributedTextField = NSAttributedString(string: emailTextField.placeholder ?? "Enter E-mail", attributes: attributes)
        let passwordAttributedTextField = NSAttributedString(string: passwordTextField.placeholder ?? "Enter Password", attributes: attributes)
        
        emailTextField.attributedPlaceholder = emailAttributedTextField
        passwordTextField.attributedPlaceholder = passwordAttributedTextField
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        let emailPaddingView = UIView(frame: CGRectMake(0, 0, 15, self.emailTextField.frame.height))
        emailTextField.leftView = emailPaddingView
        emailTextField.leftViewMode = UITextField.ViewMode.always
        let passwordPaddingView = UIView(frame: CGRectMake(0, 0, 15, self.passwordTextField.frame.height))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        
        lazy var contentView = UIStackView(arrangedSubviews: <#T##[UIView]#>, spacing: <#T##CGFloat#>, axis: <#T##NSLayoutConstraint.Axis#>, distribution: <#T##UIStackView.Distribution#>, alignment: <#T##UIStackView.Alignment#>)
        
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
            make.top.equalTo(passwordTextField.snp.bottom).offset(70)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(140)
            make.width.equalTo(350)
            make.height.equalTo(60)
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
        
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-120)
            make.top.equalTo(loginButton.snp.bottom).offset(100)
            make.width.equalTo(100)
            make.height.equalTo(1)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(120)
            make.top.equalTo(loginButton.snp.bottom).offset(100)
            make.width.equalTo(100)
            make.height.equalTo(1)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(18)
            make.top.equalTo(loginButton.snp.bottom).offset(75)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
}

