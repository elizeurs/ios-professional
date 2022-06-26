//
//  PasswordTextField.swift
//  Password
//
//  Created by Elizeu RS on 10/06/22.
//

import UIKit

class PasswordTextField: UIView {
  
  let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
  let textField = UITextField()
  let placeHolderText: String
  let eyeButton = UIButton(type: .custom)
  let dividerView = UIView()
  var errorLabel = UILabel()

//override init(frame: CGRect) {
//  super.init(frame: frame)
//
//  style()
//  layout()
//}
  
  init(placeHolderText: String ) {
    self.placeHolderText = placeHolderText
    
    super.init(frame: .zero)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 60)
  }
}

extension PasswordTextField {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
//    backgroundColor = .systemOrange
    
    lockImageView.translatesAutoresizingMaskIntoConstraints = false
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isSecureTextEntry =  false // true
    textField.placeholder = placeHolderText
//    textField.delegate = self
    textField.keyboardType = .asciiCapable // it limits the type of characters an user can type into the textfield.
    textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
    
    eyeButton.translatesAutoresizingMaskIntoConstraints = false
    eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
    eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
    eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
    
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.backgroundColor = .separator
    
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.textColor = .systemRed
    errorLabel.font = .preferredFont(forTextStyle: .footnote)
//    errorLabel.text = "Enter your password."
    errorLabel.text = "Enter your password and again and again and again and again and again and again"
    // reduce the fontSize, if you need to. if the text is too long and it doesn't fit in the allocated space
//    errorLabel.adjustsFontSizeToFitWidth = true
    // only reduce it by a maximum of 80%. the show all the text: 0.0
//    errorLabel.minimumScaleFactor = 0.0
    
    // better solution for truncate lines
    errorLabel.numberOfLines = 0
    errorLabel.lineBreakMode = .byWordWrapping
    
    errorLabel.isHidden = false // true
  }
  
  func layout() {
    addSubview(lockImageView)
    addSubview(textField)
    addSubview(eyeButton)
    addSubview(dividerView)
    addSubview(errorLabel)
    
    // lock
    NSLayoutConstraint.activate([
      lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
    
    // textfield
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: topAnchor),
      textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
    ])
    
    // eyeButton
    NSLayoutConstraint.activate([
      eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
      eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    // divider
    NSLayoutConstraint.activate([
      dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: 1),
      dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1)
    ])
    
    // errorMessageLabel
    NSLayoutConstraint.activate([
      errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.bottomAnchor, multiplier: 0.5),
      errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    // chcr
    lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
  }
}

// MARK: - Actions
extension PasswordTextField {
  @objc func togglePasswordView(_ sender: Any) {
    textField.isSecureTextEntry.toggle()
    eyeButton.isSelected.toggle()
  }
}
