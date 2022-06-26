//
//  ViewController.swift
//  Password
//
//  Created by Elizeu RS on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
  
  let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
  let stackView = UIStackView()
  
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
  }
  
  func layout() {
    stackView.addArrangedSubview(newPasswordTextField)
    
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

