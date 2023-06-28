//
//  NotifTableViewCell.swift
//  vlogsApp
//
//  Created by Petar Popovski on 28.6.23.
//

import UIKit

class NotifTableViewCell: UITableViewCell {
    
    static let identifier = "NotifTableViewCell"
    
    lazy var newsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with label: String) {
        let attributedString = NSMutableAttributedString(string: label)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        newsLabel.attributedText = attributedString
    }
}
