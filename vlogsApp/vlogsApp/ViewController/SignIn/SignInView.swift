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
    func navigationToRegisterView()
}

class SignInView: UIView {
    
    weak var delegate: SignInProtocol? = nil

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.text = "test@gmail.com" // WILL REMOVE THIS ( EAZY LOG IN )
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
        delegate?.navigationToRegisterView()
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
        
        lazy var stackViewEmail = UIStackView(arrangedSubviews: [emailPlaceholder, emailTextField], spacing: 12, axis: .vertical, distribution: .fill, alignment: .fill, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        lazy var stackViewPassword = UIStackView(arrangedSubviews:
        [passwordPlaceholder, passwordTextField, noCredentialsAlert], spacing: 12, axis: .vertical, distribution: .fill, alignment: .fill, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        lazy var horizontalLineStackView = UIStackView(arrangedSubviews: [lineView, signUpLabel, secondLineView], spacing: 0, axis: .horizontal, distribution: .equalSpacing, alignment: .center, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        lazy var buttonStackView = UIStackView(arrangedSubviews: [loginButton, horizontalLineStackView, registerButton], spacing: 30, axis: .vertical, distribution: .fillEqually, alignment: .fill, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(buttonStackView)
        addSubview(stackViewEmail)
        addSubview(stackViewPassword)
        
        stackViewEmail.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        stackViewPassword.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(stackViewEmail.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(1)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(1)
        }
    }
}

