//
//  ViewController.swift
//  Password
//
//  Created by Elizeu RS on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
  typealias CustomValidation = PasswordTextField.CustomValidation
  
  let stackView = UIStackView()
  let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
//  let criteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
  let statusView = PasswordStatusView()
  let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
  let resetButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    style()
    layout()
  }
}

extension ViewController {
  func setup() {
    setupNewPassword()
    setupConfirmPassword()
    setupDismissKeyboardGesture()
  }
  
//  typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
  
  private func setupNewPassword() {
    let newPasswordValidation: CustomValidation = { text in
      
      // empty text
      guard let text = text, !text.isEmpty else {
         self.statusView.reset()
        return (false, "Enter your password")
      }
      
      // valid characters
      let validChars = "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ01234567890"
      let invalidSet = CharacterSet(charactersIn: validChars).inverted
      guard text.rangeOfCharacter(from: invalidSet) == nil else {
        self.statusView.reset()
        return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
      }
      
      // criteria met
      self.statusView.updateDisplay(text)
      if !self.statusView.validate(text) {
        return (false, "Your password must meet the requirements below")
      }
      
      return (true, "")
    }
    
    newPasswordTextField.customValidation = newPasswordValidation
    newPasswordTextField.delegate = self
  }
  
  private func setupConfirmPassword() {
    let confirmPasswordValidation: CustomValidation = { text in
      guard let text =  text, !text.isEmpty else {
        return (false, "Enter your password.")
      }
      
      guard text == self.newPasswordTextField.text else {
        return (false, "Passwords do not match.")
      }
      
      return (true, "")
    }
    
    confirmPasswordTextField.customValidation = confirmPasswordValidation
    confirmPasswordTextField.delegate = self
  }
  
  // hide keyboard after losing focus
  private func setupDismissKeyboardGesture() {
    let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
    view.addGestureRecognizer(dismissKeyboardTap)
  }
  
  @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
    view.endEditing(true) // resign  first responder
  }
  
  func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    
//    criteriaView.translatesAutoresizingMaskIntoConstraints = false
    
    statusView.translatesAutoresizingMaskIntoConstraints = false
    statusView.layer.cornerRadius = 10
    statusView.clipsToBounds = true
    
    confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    resetButton.translatesAutoresizingMaskIntoConstraints = false
    resetButton.configuration = .filled()
    resetButton.setTitle("Reset password", for: [])
//    resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
  }
  
  func layout() {
    stackView.addArrangedSubview(newPasswordTextField)
    stackView.addArrangedSubview(statusView)
    stackView.addArrangedSubview(confirmPasswordTextField)
    stackView.addArrangedSubview(resetButton)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
      
    ])
    
//    NSLayoutConstraint.activate([
//      newPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
  }
}

//  MARK: PasswordTextFieldDelegate
extension ViewController: PasswordTextFieldDelegate {
  func editingChanged(_ sender: PasswordTextField) {
    if sender === newPasswordTextField {
       statusView.updateDisplay(sender.textField.text ?? "")
    }
  }
  
  func editingDidEnd(_ sender: PasswordTextField) {
//    print("foo - ViewController editingDidEnd: \(sender.textField.text)")
    if sender === newPasswordTextField {
      // as soon as we lose focus, make X appear
      statusView.shouldResetCriteria = false
      _ = newPasswordTextField.validate()
    } else if sender == confirmPasswordTextField {
      _ = confirmPasswordTextField.validate()
    }
  }
}

