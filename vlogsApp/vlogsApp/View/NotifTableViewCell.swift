//
//  NotifTableViewCell.swift
//  vlogsApp
//
//  Created by Petar Popovski on 28.6.23.
//

import UIKit
import SnapKit

class NotifTableViewCell: UITableViewCell {
    
    static let identifier = "NotifTableViewCell"
    lazy var newNotif = false
    
    lazy var newsLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(named: "titleColor".localized())
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var whatsNewLabel: UILabel = {
       var label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 9, weight: .bold)
        label.text = "NEW"
        label.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(40)
        }
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        return label
    }()
    
    lazy var cellLabelsStack: UIStackView = {
        var stack = UIStackView()
        stack.addArrangedSubview(whatsNewLabel)
        stack.addArrangedSubview(newsLabel)
        stack.axis = .horizontal
        stack.spacing = 3
        return stack
    }()
    
    lazy var whatsNewStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [whatsNewLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.isHidden = true
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(whatsNewLabel)
        contentView.addSubview(newsLabel)
        
         newsLabel.snp.makeConstraints { make in
             make.top.bottom.trailing.equalToSuperview().inset(10)
             if newNotif {
                 make.leading.equalToSuperview().inset(35)
             } else {
                 make.leading.equalToSuperview().inset(40)
             }
        }
        whatsNewLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY).offset(-7)
            make.centerX.equalTo(20)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with label: String) {
        let attributedString = NSMutableAttributedString(string: label)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        newsLabel.attributedText = attributedString
    }
}
