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
    
    lazy var descriptionTextField: UITextField = {
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
    
    lazy var dateAndImageStackView = UIStackView(arrangedSubviews: [datePicker, imageView], spacing: 12, axis: .vertical, distribution: .fill, alignment: .center, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    lazy var buttonAndTextFieldStackView = UIStackView(arrangedSubviews: [photoPickerButton, titleTextField, descriptionTextField, dateAndImageStackView], spacing: 12, axis: .vertical, distribution: .fill, alignment: .fill, layoutMargins: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
    
    lazy var categoryStackView = UIStackView(arrangedSubviews: [racingLabel, categorySwitch, gamingLabel], spacing: 12, axis: .horizontal, distribution: .fill, alignment: .fill, layoutMargins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    override init (frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)]
        
        let titleAttributedTextField = NSAttributedString(string: titleTextField.placeholder ?? "Enter Title", attributes: attributes)
        let descriptionAttributedTextField = NSAttributedString(string: descriptionTextField.placeholder ?? "Enter Description", attributes: attributes)
        
        titleTextField.attributedPlaceholder = titleAttributedTextField
        descriptionTextField.attributedPlaceholder = descriptionAttributedTextField
        
        let titlePaddingView = UIView(frame: CGRectMake(0, 0, 15, self.titleTextField.frame.height))
        titleTextField.leftView = titlePaddingView
        titleTextField.leftViewMode = UITextField.ViewMode.always
        
        let descriptionPaddingView = UIView(frame: CGRectMake(0, 0, 15, self.descriptionTextField.frame.height))
        descriptionTextField.leftView = descriptionPaddingView
        descriptionTextField.leftViewMode = UITextField.ViewMode.always
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        addSubview(buttonAndTextFieldStackView)
        addSubview(categoryStackView)
        addSubview(postButton)
        
        buttonAndTextFieldStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        
        photoPickerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.height.equalTo(140)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(12)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(datePicker.snp.bottom).offset(12)
            make.bottom.equalTo(categoryStackView.snp.top).offset(-12)
        }
        
        categoryStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(postButton.snp.top).offset(-12)
        }
        
        postButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(50)
            make.width.equalTo(350)
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
