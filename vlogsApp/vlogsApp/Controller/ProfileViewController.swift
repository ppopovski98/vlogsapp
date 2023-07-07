//
//  ProfileViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit
import SafariServices

class ProfileViewController: UIViewController {
    
    lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilePic")
        imageView.makeRounded()
        return imageView
    }()
    
    let youtubeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "youtubeButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapYoutube), for: .touchUpInside)
        return button
    }()
    
    let twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitterButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapTwitter), for: .touchUpInside)
        return button
    }()
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebookButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapFacebook), for: .touchUpInside)
        return button
    }()
    
    let aboutMeDescription = UILabel()
    let aboutMeTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutMeConfigUI()
        configUI()
    }
    
    lazy var buttonStackView = UIStackView(arrangedSubviews: [youtubeButton, twitterButton, facebookButton], spacing: 5, axis: .horizontal, distribution: .fillEqually, alignment: .center, layoutMargins: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    
    func configUI() {
        
        title = "Profile"
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        view.addSubview(buttonStackView)
        view.addSubview(profilePic)
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(aboutMeDescription.snp.bottom).offset(-200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
        
        profilePic.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-200)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-500)
            make.width.height.equalTo(20)
        }
        
        aboutMeTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(profilePic.snp.bottom).offset(20)
            make.bottom.equalTo(aboutMeDescription.snp.top).offset(200)
            make.width.height.equalTo(20)
        }
        
        aboutMeDescription.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(aboutMeTitle.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    func aboutMeConfigUI() {
        
        aboutMeTitle.text = "ABOUT ME"
        aboutMeTitle.numberOfLines = 1
        aboutMeTitle.layer.cornerRadius = 20
        aboutMeTitle.tintColor = .black
        aboutMeTitle.textAlignment = .left
        view.addSubview(aboutMeTitle)
        
        aboutMeDescription.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer interdum maximus sem, in elementum ex gravida a. Etiam eget laoreet felis, ac condimentum nisi. Pellentesque maximus, massa vitae faucibus mattis, libero lacus porttitor nisl, a tincidunt justo dolor id augue. Aenean sit amet nisi enim. Sed sit amet mi sem. Nulla placerat nec quam nec malesuada. Phasellus nibh arcu, commodo placerat sodales in, cursus in velit. Phasellus varius suscipit nisl, et euismod metus lobortis at."
        aboutMeDescription.numberOfLines = 20
        aboutMeDescription.layer.cornerRadius = 20
        aboutMeDescription.tintColor = .black
        aboutMeDescription.textAlignment = .left
        view.addSubview(aboutMeDescription)
    }
    
    @objc func didTapYoutube() {
        if let url = URL(string: "https://www.youtube.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapTwitter() {
        if let url = URL(string: "https://www.twitter.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapFacebook() {
        if let url = URL(string: "https://www.facebook.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
