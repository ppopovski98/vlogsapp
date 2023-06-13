//
//  BlogCollectionViewCell.swift
//  vlogsApp
//
//  Created by Petar Popovski on 7.6.23.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "vlogPicExample")
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
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .red
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
        imageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-10, height: contentView.frame.size.height-80)
        descriptionLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-80, width: contentView.frame.size.width-10, height: 100)
        dateAndTimeLabel.frame = CGRect(x: 250, y: contentView.frame.size.height-80, width: contentView.frame.size.width-10, height: 50)
        favouritesButton.frame = CGRect(x: 250, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)

    }
    
    func blogCellConfigUI() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .white
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateAndTimeLabel)
        contentView.addSubview(favouritesButton)
    }
}
