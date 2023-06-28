//
//  BlogCollectionViewCell.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit
import SnapKit

class BlogCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BlogCollectionViewCell"
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "10.06.2023"
        return label
    }()
    
    let favouritesButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        blogCellConfigUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, UIView()], spacing: 50, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 100, left: 12, bottom: 0, right: 12))

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-60)
            make.right.equalTo(dateAndTimeLabel.snp.left).offset(-10)
            make.height.equalTo(50)
        }

        postImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(titleLabel.snp.top).offset(-5)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(1)
            make.right.equalTo(favouritesButton.snp.left).offset(5)
            make.height.equalTo(100)
        }

        dateAndTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(250)
            make.bottom.equalTo(contentView.snp.bottom).offset(-60)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(50)
        }

        favouritesButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(250)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.width.equalTo(150)
            make.height.equalTo(100)
        }


    }
    
    func blogCellConfigUI() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = UIColor(named: "textFieldColor")
        
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateAndTimeLabel)
        contentView.addSubview(favouritesButton)
        
    }
}
