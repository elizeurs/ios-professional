//
//  ViewController.swift
//  Password
//
//  Created by Elizeu RS on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
  
  let stackView = UIStackView()
  let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
//  let criteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
  let statusView = PasswordStatusView()
  let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
  let resetButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension ViewController {
  func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    newPasswordTextField.delegate = self
    
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
}

