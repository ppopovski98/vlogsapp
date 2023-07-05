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
    
    lazy var placeholderView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
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
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "dd.MM.yyyy"
        
        let label = UILabel()
        label.text = formatter.string(from: date)
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .systemBlue
        label.textAlignment = .right
    
        return label
    }()
    
    let postDateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .systemBlue
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let favouritesButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
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
    
    lazy var descriptionStackView = UIStackView(arrangedSubviews: [descriptionLabel], spacing: 5, axis: .horizontal, distribution: .fill, alignment: .leading, layoutMargins: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    
    lazy var dateStackView =  UIStackView(arrangedSubviews: [postDateIcon, dateLabel], spacing: 5, axis: .horizontal, distribution: .fill, alignment: .leading, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    lazy var dateAndTitleStackView = UIStackView(arrangedSubviews: [titleLabel, placeholderView, dateStackView], spacing: 5, axis: .horizontal, distribution: .equalCentering, alignment: .leading, layoutMargins: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8))
    
    lazy var combinedStackView = UIStackView(arrangedSubviews: [postImageView, dateAndTitleStackView, descriptionStackView, favouritesButton], spacing: 5, axis: .vertical, distribution: .equalCentering, alignment: .center, layoutMargins: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(8)
            make.top.equalTo(dateAndTitleStackView.snp.bottom).offset(-100)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        combinedStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        postImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(dateAndTitleStackView.snp.top)
            make.height.equalTo(150)
        }
        
        dateAndTitleStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(8)
            make.bottom.equalTo(contentView.snp.bottom)
            make.top.equalTo(postImageView.snp.bottom)
        }
        
        favouritesButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(300)
            make.bottom.equalTo(contentView.snp.bottom)
            make.top.equalTo(descriptionLabel.snp.bottom)
        }
    }
    
    func blogCellConfigUI() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = UIColor(named: "textFieldColor")
        
        contentView.addSubview(postImageView)
        contentView.addSubview(dateAndTitleStackView)
        contentView.addSubview(combinedStackView)
        contentView.addSubview(descriptionStackView)
        contentView.addSubview(favouritesButton)
    }
}
