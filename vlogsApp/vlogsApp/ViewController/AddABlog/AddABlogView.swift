//
//  AddABlogView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

protocol AddABlogProtocol: AnyObject {
    func photoPickerButtonTapped()
    func postButtonTapped()
    func datePickerValueChange()
    func categorySwitchValue()
}

class AddABlogView: UIView {
    
    weak var delegate: AddABlogProtocol? = nil
    lazy var imageView = UIImageView()
    
    lazy var photoPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.setTitle("UPLOAD A PHOTO", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(photoPickerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var titleTextField: UITextField = {
        let title = UITextField()
        title.backgroundColor = .white
        title.textColor = .black
        title.layer.cornerRadius = 10
        return title
    }()
    
    lazy var descritptionTextField: UITextField = {
        let title = UITextField()
        title.backgroundColor = .white
        title.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        title.textColor = .black
        title.layer.cornerRadius = 10
        return title
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "textFieldColor")
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        button.setTitle("POST", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerValueChange), for: .valueChanged)
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    lazy var categorySwitch: UISwitch = {
       let uiSwitch = UISwitch()
        uiSwitch.addTarget(self, action: #selector(categorySwitchValue), for: .valueChanged)
        return uiSwitch
    }()
    
    lazy var gamingLabel: UILabel = {
        let label = UILabel()
        label.text = "Gaming Category"
        label.textColor = UIColor(named: "titleColor")
        return label
    }()
    
    lazy var racingLabel: UILabel = {
        let label = UILabel()
        label.text = "Racing Category"
        label.textColor = UIColor(named: "titleColor")
        label.textAlignment = .right
        return label
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleTextField, descritptionTextField, UIView()], spacing: 12, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 100, left: 12, bottom: 0, right: 12))
    
    override init (frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        addSubview(stackView)
        addSubview(postButton)
        addSubview(photoPickerButton)
        addSubview(imageView)
        addSubview(datePicker)
        addSubview(categorySwitch)
        addSubview(gamingLabel)
        addSubview(racingLabel)
        
        photoPickerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleTextField.snp.top).offset(-10)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        postButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(categorySwitch.snp.bottom).offset(12)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        descritptionTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(85)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descritptionTextField.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(250)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descritptionTextField.snp.bottom).offset(20)
        }
        
        categorySwitch.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        gamingLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(12)
            make.left.equalTo(categorySwitch.snp.right).offset(5)
            make.bottom.equalTo(postButton.snp.top).offset(-10)
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        racingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(categorySwitch.snp.left).offset(-5)
            make.bottom.equalTo(postButton.snp.top).offset(-10)
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
    }
    
    @objc func photoPickerButtonTapped() {
        delegate?.photoPickerButtonTapped()
    }
    
    @objc func postButtonTapped() {
        delegate?.postButtonTapped()
    }
    
    @objc func datePickerValueChange() {
        delegate?.datePickerValueChange()
    }
    
    @objc func categorySwitchValue() {
        delegate?.categorySwitchValue()
    }
}
