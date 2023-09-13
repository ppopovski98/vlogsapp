//
//  ProfileViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SafariServices
import FirebaseAuth

class ProfileViewController: BaseUiNavigationBarAppearance {
    
    var profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.delegate = self
        
        title = "Profile"
        
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func didTapLogOut () {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            if let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navController.isNavigationBarHidden = false
                navController.popToRootViewController(animated: true)
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: -

extension ProfileViewController: ProfileViewProtocol {
    
    @objc func didTapYoutubeButton() {
        if let url = URL(string: "https://www.youtube.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapTwitterButton() {
        if let url = URL(string: "https://www.twitter.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapFacebookButton() {
        if let url = URL(string: "https://www.facebook.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
