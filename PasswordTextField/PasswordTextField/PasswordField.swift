//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    
    enum PasswordStrength: String {
        case weak = "Weak"
        case medium = "Medium"
        case strong = "Strong"
    }
    
    var passwordStrength: PasswordStrength = .weak
    
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    
    func setup() {
        backgroundColor = bgColor
        // Lay out your subviews here
        
        // MARK: - Enter Password
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.text = "Enter Password"
        titleLabel.textAlignment = .left
        
        // MARK: - Text Field
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.frame.size.height = textFieldContainerHeight
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 4
        
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = true
        textField.font = labelFont
        textField.text = "test"
        textField.becomeFirstResponder()
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // MARK: - Show, Hide Button
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame.size = CGSize(width: textFieldContainerHeight - 4, height: textFieldContainerHeight - 4)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4)
        ])
        
        // MARK: - Weak View
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 3
        
        // MARK: Strength Description Label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
        
        strengthDescriptionLabel.text = "weak"
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.textAlignment = .left
    }
    
    @objc func showHideButtonTapped() {
        if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
