//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

// Testing

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
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
    
    // MARK: - Properties
    private var passwordContainerView: UIView = UIView()
    private var passwordIndicatorWeakView: UIView = UIView()
    private var passwordIndicatorMediumView: UIView = UIView()
    private var passwordIndicatorStrongView: UIView = UIView()
    
    // MARK: - Methods and Functions
    func setup() {
        // Lay out your subviews here
        
        // Title Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        titleLabel.textColor = .gray
        
        // Title container view
        addSubview(passwordContainerView)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordContainerView.layer.borderColor = UIColor.black.cgColor
        passwordContainerView.layer.borderWidth = 2.0
        passwordContainerView.layer.cornerRadius = 5.0
        
        // Password Strength Indicators
        
        // Weak
        addSubview(passwordIndicatorWeakView)
        passwordIndicatorWeakView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordIndicatorWeakView.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -10).isActive = true
        passwordIndicatorWeakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        passwordIndicatorWeakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        passwordIndicatorWeakView.widthAnchor.constraint(equalToConstant: 50).isActive = true

        passwordIndicatorWeakView.layer.backgroundColor = UIColor.green.cgColor
        passwordIndicatorWeakView.layer.borderWidth = 0.5
        
        // Medium
        addSubview(passwordIndicatorMediumView)
        passwordIndicatorMediumView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordIndicatorMediumView.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -10).isActive = true
        passwordIndicatorMediumView.leadingAnchor.constraint(equalTo: passwordIndicatorWeakView.trailingAnchor, constant: 5).isActive = true
        
        passwordIndicatorMediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        passwordIndicatorMediumView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordIndicatorMediumView.layer.backgroundColor = UIColor.yellow.cgColor
        passwordIndicatorMediumView.layer.borderWidth = 0.5
        
        // Strong
        addSubview(passwordIndicatorStrongView)
        passwordIndicatorStrongView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordIndicatorStrongView.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -10).isActive = true
        passwordIndicatorStrongView.leadingAnchor.constraint(equalTo: passwordIndicatorMediumView.trailingAnchor, constant: 5).isActive = true
        
        passwordIndicatorStrongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        passwordIndicatorStrongView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordIndicatorStrongView.layer.backgroundColor = UIColor.red.cgColor
        passwordIndicatorStrongView.layer.borderWidth = 0.5
        
        // 
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
