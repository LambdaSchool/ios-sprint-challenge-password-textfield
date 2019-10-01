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
    
    func setup() {
        // Lay out your subviews here
        // TITLE LABEL
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
        ])
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.text = "ENTER PASSWORD"
        
        // TEXTFIELD
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = standardMargin
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = bgColor
        
        // SHOW/HIDE BUTTON
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        
        // WEAKVIEW
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        
        ])
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        
        ])
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        
        ])
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        
        ])
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
        determineStrength(newText.count)
        
        return true
    }
    
    func determineStrength(_ textLength: Int) {
        switch textLength {
        case 1..<9:
            weakView.tintColor = weakColor
            mediumView.tintColor = unusedColor
            strongView.tintColor = unusedColor
        case 9..<18:
            weakView.tintColor = weakColor
            mediumView.tintColor = mediumColor
            strongView.tintColor = unusedColor
        case 18..<36:
            weakView.tintColor = weakColor
            mediumView.tintColor = mediumColor
            strongView.tintColor = strongColor
        default:
            weakView.tintColor = unusedColor
            mediumView.tintColor = unusedColor
            strongView.tintColor = unusedColor
            
        }
    }
}
