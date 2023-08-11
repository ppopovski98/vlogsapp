//
//  ViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 1.6.23.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    private var viewModel: SignInViewModel?
    
    var signInView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log In"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(signInView)
        signInView.delegate = self
        
        signInView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    init(viewModel: SignInViewModel) {
        super.init(nibName: .none, bundle: .none)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Timer and alert message for no credentials.
    
    func startTimer() {
        
        signInView.noCredentialsAlert.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false ) { [weak self] timer in
            self?.signInView.noCredentialsAlert.isHidden = true
            timer.invalidate()
        }
    }
    
    func alertMessage() {
        
        let alert = UIAlertController(title: "No account with these credentials.", message: "Please create or sign in with an existing account.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


extension SignInViewController: SignInProtocol {
    
    func navigationSomehting() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func loginButtonTapped() {
        guard let email = signInView.emailTextField.text, !email.isEmpty,
              let password = signInView.passwordTextField.text, !password.isEmpty else {
            self.startTimer()
            return
        }
        
        viewModel?.signIn(email: email, password: password) { success, error in
            
            if success {
                let tabBarViewController = TabBarViewController()
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
                print("Success")
            } else {
                self.alertMessage()
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
}

