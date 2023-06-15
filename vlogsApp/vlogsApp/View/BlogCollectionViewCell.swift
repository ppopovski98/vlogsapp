//
//  BlogCollectionViewCell.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit

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
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "10.06.2023"
        return label
    }()
    
    let favouritesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.tintColor = .black
        button.setTitle("Favourites", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        blogCellConfigUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-80, width: contentView.frame.size.width-10, height: 50)
        postImageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-10, height: contentView.frame.size.height-80)
        descriptionLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-80, width: contentView.frame.size.width-10, height: 100)
        dateAndTimeLabel.frame = CGRect(x: 250, y: contentView.frame.size.height-80, width: contentView.frame.size.width-10, height: 50)
        favouritesButton.frame = CGRect(x: 250, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 20)

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
