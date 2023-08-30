//
//  ProfileView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

protocol ProfileViewProtocol: AnyObject {
    func didTapYoutubeButton()
    func didTapTwitterButton()
    func didTapFacebookButton()
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewProtocol?
    
    lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilePic")
        imageView.makeRounded()
        return imageView
    }()
    
    lazy var youtubeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "youtubeButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapYoutubeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitterButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapTwitterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebookButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapFacebookButton), for: .touchUpInside)
        return button
    }()
    
    lazy var aboutMeTitle: UILabel = {
        let label = UILabel()
        label.text = "ABOUT ME"
        label.numberOfLines = 1
        label.layer.cornerRadius = 20
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var aboutMeDescription: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer interdum maximus sem, in elementum ex gravida a. Etiam eget laoreet felis, ac condimentum nisi. Pellentesque maximus, massa vitae faucibus mattis, libero lacus porttitor nisl, a tincidunt justo dolor id augue. Aenean sit amet nisi enim. Sed sit amet mi sem. Nulla placerat nec quam nec malesuada. Phasellus nibh arcu, commodo placerat sodales in, cursus in velit. Phasellus varius suscipit nisl, et euismod metus lobortis at."
        label.numberOfLines = 20
        label.layer.cornerRadius = 20
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var buttonStackView = UIStackView(arrangedSubviews: [youtubeButton, twitterButton, facebookButton], spacing: 5, axis: .horizontal, distribution: .fillEqually, alignment: .center, layoutMargins: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))

    override init (frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        addSubview(buttonStackView)
        addSubview(profilePic)
        addSubview(aboutMeTitle)
        addSubview(aboutMeDescription)
        
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
    
    @objc func didTapYoutubeButton() {
        delegate?.didTapYoutubeButton()
    }
    
    @objc func didTapTwitterButton() {
        delegate?.didTapTwitterButton()
    }
    @objc func didTapFacebookButton() {
        delegate?.didTapFacebookButton()
    }
}
