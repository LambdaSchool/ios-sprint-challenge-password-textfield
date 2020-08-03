//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
enum PasswordStrength: String {
    case weak = "Too Weak"
    case medium = "Strong Password"
    case hard = "Verry Strong Password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength = ""
    
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
    
    var showPassword: Bool = true {
        didSet {
            textField.isSecureTextEntry = showPassword
            if showPassword {
                showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
            } else {
                showHideButton.setImage(UIImage(named: "eyes-open.pgn"), for: .normal)
            }
        }
    }
    override var instinsicContentSize: CGSize {
        return CGSize(width: 150, heigt: 150)
    }
    @objc private func showPassword() {
        showPassword.toggle()
    }
    
    func setup() {
        // Lay out your subviews here
        self.backgroundColor = bgColor
        
        //LABEL "ENTER PASSWORD"
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        //LABEL CONSTRAINTS
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin).isActive = true
        
        //TEXTFIELD
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = bgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        //TEXT FIELD CONSTRAINTS
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        //PRIVACY EYE BUTTON
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        
        //VIEW CONTAINER + PASSWORD STRENGTH
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        weakView.layer.cornerRadius = 2
        mediumView.layer.cornerRadius = 2
        strongView.layer.cornerRadius = 2
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //PASSWORD STRENGTH LABEL CONSTRAINTS
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
        
        
        
    }
    
    private func passwordStrengthChecker() {
        if password.count < 7 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Weak Password"
         }
        else if password.count > 12 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Strong Password"
        }
        else if password.count > 16 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Very Strong Password"
        }
        
    }
    private func passwordAnimation(with view: UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(scaleX: 1, y: 2)})
        { (_) in
            UIView.animate(durration: 0.2) {
                view.tranform = .identity
            }
        }
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
