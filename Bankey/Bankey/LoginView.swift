//
//  LoginView.swift
//  Bankey
//
//  Created by Elizeu RS on 20/03/22.
//

import Foundation
import UIKit

class LoginView: UIView {
  
  let stackView = UIStackView()
  let usernameTextField = UITextField()
  let passwordTextField = UITextField()
  let dividerView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  // because we have stackview and the elements inside it(textFields), have their own intrinsicContentSize, we don't need it anymore.
//  override var intrinsicContentSize: CGSize {
//    return CGSize(width: 200, height: 200)
//  }
}

extension LoginView {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .secondarySystemFill
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 8
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.placeholder = "Username"
    usernameTextField.delegate = self
    
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    passwordTextField.delegate = self
    
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.backgroundColor = .secondarySystemFill
  }
  
  func layout() {
    stackView.addArrangedSubview(usernameTextField)
    stackView.addArrangedSubview(dividerView)
    stackView.addArrangedSubview(passwordTextField)
    
    addSubview(stackView)
    
    //Activate Constraints Array Snippet
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
      bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
    ])
    
    dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    layer.cornerRadius = 5
    clipsToBounds = true
  }
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    usernameTextField.endEditing(true)
    passwordTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
  }
}
