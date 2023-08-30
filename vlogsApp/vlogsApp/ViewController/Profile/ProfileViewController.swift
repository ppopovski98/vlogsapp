//
//  ProfileViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SafariServices

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
