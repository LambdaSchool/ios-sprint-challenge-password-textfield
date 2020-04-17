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
    var isTextHidden = true
    
    enum PasswordStrength: String {
        case bad = "Too weak"
        case ok = "Could be stronger"
        case good = "Strong password"
    }
    
    var strength: PasswordStrength = .bad
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    //private let viewSize = CGRect(x: 0, y: 0, width: 50, height: 50)
    
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
    private var showHideButton: UIButton = UIButton(type: .custom)
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        setupTitleLabel()
        setupTextField()
        setupShowHideButton()
        setupViews()
        setupStrengthLabel()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }*/
    
    
    
    func determineStrength(text: String) {
        switch text.count {
        case 0...9:
            strength = .bad
        case 10...19:
            strength = .ok
        case 20...:
            strength = .good
        default:
            strength = .good
        }
        print(strength.rawValue)
    }
    
    //MARK: - Actions
    @objc func textFieldEdited() {
        guard let text = textField.text else { return }
        determineStrength(text: text)
    }
    
    @objc func textFieldEndEditing() {
        print(textField.text)
    }
    
    @objc func buttonPressed() {
        if isTextHidden == true {
            guard let image = UIImage(named: "eyes-open") else { return }
            showHideButton.setImage(image, for: .normal)
            textField.isSecureTextEntry = false
            isTextHidden = false
        } else {
            guard let image = UIImage(named: "eyes-closed") else { return }
            showHideButton.setImage(image, for: .normal)
            textField.isSecureTextEntry = true
            isTextHidden = true
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


extension PasswordField {
    func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)])
        
    }
    
    func setupTextField() {
        textField.font = .systemFont(ofSize: 32, weight: .medium)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldEndEditing), for: .touchDown)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0.0)
            ])
    }
    
    func setupShowHideButton() {
    
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        guard let image = UIImage(named: "eyes-closed") else {
            return
        }
        showHideButton.isUserInteractionEnabled = true
        showHideButton.setImage(image, for: .normal)
        showHideButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: showHideButton, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: showHideButton, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1.0, constant: -10.0)])
    }
    
    func setupViews() {
        weakView.backgroundColor = .red
        mediumView.backgroundColor = .orange
        strongView.backgroundColor = .green
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.frame.size = colorViewSize
        mediumView.frame.size = colorViewSize
        strongView.frame.size = colorViewSize
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: weakView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: weakView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: weakView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.20, constant: 0.0),
            NSLayoutConstraint(item: weakView, attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 0.25, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: mediumView, attribute: .top, relatedBy: .equal, toItem: weakView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: mediumView, attribute: .leading, relatedBy: .equal, toItem: weakView, attribute: .trailing, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: mediumView, attribute: .width, relatedBy: .equal, toItem: weakView, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: mediumView, attribute: .height, relatedBy: .equal, toItem: weakView, attribute: .height, multiplier: 1.0, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: strongView, attribute: .top, relatedBy: .equal, toItem: mediumView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: strongView, attribute: .leading, relatedBy: .equal, toItem: mediumView, attribute: .trailing, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: strongView, attribute: .width, relatedBy: .equal, toItem: mediumView, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: strongView, attribute: .height, relatedBy: .equal, toItem: mediumView, attribute: .height, multiplier: 1.0, constant: 0.0)
        ])
    }
    
    func setupStrengthLabel() {
        strengthDescriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        strengthDescriptionLabel.text = strength.rawValue
        strengthDescriptionLabel.textColor = .black
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: strongView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: strongView, attribute: .trailing, multiplier: 1.0, constant: 5.0)
        ])
        
        
    }
    
    
    
}
