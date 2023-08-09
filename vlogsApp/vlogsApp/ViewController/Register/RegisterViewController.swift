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
    
    private var viewModel: RegisterViewModel?
    
    lazy var registerEmail: UITextField = {
        let textField = UITextField()
        paddingView(textField)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.placeholder = "E-mail"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.textColor = .black
        textField.layer.borderWidth = 0.5
        textField.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        return textField
    }()
    
    lazy var registerPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        paddingView(textField)
        textField.textColor = .black
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .white
        textField.layer.borderWidth = 0.5
        textField.frame = CGRect(x: 100, y: 150, width: 350, height: 40)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let UIbutton = UIButton()
        UIbutton.setTitle("CREATE AN ACCOUNT", for: .normal)
        UIbutton.setTitleColor(.black, for: .normal)
        UIbutton.backgroundColor = UIColor(named: "textFieldColor")
        UIbutton.layer.cornerRadius = 20
        UIbutton.frame = CGRect(x: 100, y: 100, width: 350, height: 50)
        UIbutton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        UIbutton.translatesAutoresizingMaskIntoConstraints = false
        return UIbutton
    }()
    
    lazy var enterEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textColor = .gray
        return label
    }()
    
    lazy var enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .gray
        return label
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [registerEmail, registerPassword, UIView()], spacing: 50, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 100, left: 12, bottom: 0, right: 12))

    override func viewDidLoad() {
        super.viewDidLoad()

        registerConfigUI()
        viewModel = RegisterViewModel()
    }
    
    //Config for the register button, email and password.
    
    func registerConfigUI() {
        
        view.addSubview(enterEmailLabel)
        view.addSubview(enterPasswordLabel)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        navigationController?.navigationBar.tintColor = UIColor(named: "titleColor")
        
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
    
    func paddingView(_ textField: UITextField) {
        let emailPaddingView = UIView(frame: CGRectMake(0, 0, 15, textField.frame.height))
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)]
        let attributedTextField = NSAttributedString(string: textField.placeholder ?? "E-mail", attributes: attributes)
        textField.leftView = emailPaddingView
        textField.attributedPlaceholder = attributedTextField
        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    @objc func registerButtonTapped() {
        guard let email = registerEmail.text, !email.isEmpty,
              let password = registerPassword.text, !password.isEmpty else {
            return
        }
        
        viewModel?.createAccount(email: email, password: password, completion: { success, error in
            if success {
                let tabBarViewController = TabBarViewController()
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
                print("Success.")
            } else {
                print(error?.localizedDescription ?? "Error.")
            }
        })
    }
}

