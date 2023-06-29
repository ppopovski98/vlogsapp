//
//  ProfileViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilePic")
        imageView.makeRounded()
        return imageView
    }()
    
    let aboutMe = UILabel()
    let aboutMeTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutMeConfigUI()
        configUI()
    }
    
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
        
        view.addSubview(profilePic)
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
            make.bottom.equalTo(aboutMe.snp.top).offset(200)
            make.width.height.equalTo(20)
        }
        
        aboutMe.snp.makeConstraints { make in
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
        
        aboutMe.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer interdum maximus sem, in elementum ex gravida a. Etiam eget laoreet felis, ac condimentum nisi. Pellentesque maximus, massa vitae faucibus mattis, libero lacus porttitor nisl, a tincidunt justo dolor id augue. Aenean sit amet nisi enim. Sed sit amet mi sem. Nulla placerat nec quam nec malesuada. Phasellus nibh arcu, commodo placerat sodales in, cursus in velit. Phasellus varius suscipit nisl, et euismod metus lobortis at."
        aboutMe.numberOfLines = 20
        aboutMe.layer.cornerRadius = 20
        aboutMe.tintColor = .black
        aboutMe.textAlignment = .left
        view.addSubview(aboutMe)
    }
    
}
