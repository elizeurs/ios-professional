//
//  ViewController.swift
//  Sandbox
//
//  Created by Elizeu RS on 01/07/22.
//

import UIKit

class ViewController: UIViewController {
  
  let texField = UITextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension ViewController {
  func style() {
    texField.translatesAutoresizingMaskIntoConstraints = false
    texField.placeholder = "New password"
    texField.backgroundColor = .systemGray6
    // to receive msgs from the uitextfield
    texField.delegate = self
    
    // extra interaction
    texField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
  }
  
  func layout() {
    view.addSubview(texField)
    
    NSLayoutConstraint.activate([
      texField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      texField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: texField.trailingAnchor, multiplier: 2)
    ])
  }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  
  // return NO to  disallow editing.
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true
  }
  
  // become first responder: i am first in line when it comes to responding to ui events.
  func textFieldDidBeginEditing(_ textField: UITextField) {
  }
  
  // return YES to allow editing to stop and to resign first responder status (i am no longer first in line).
  // return NO to disallow the editing session to end
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true
  }
  
  // if implemented, called in place of textFieldDidEndEditing: ?
  func textFieldDidEndEditing(_ textField: UITextField) {
  }
  
  // detect - keypress
  // return NO to not change text
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let word = textField.text ?? ""
    let char = string
//    print("Default - shouldChangeCharactersIn: \(word) \(char)")
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.endEditing(true) // resign first responder
    return true
  }
}

// MARK: - Extra Actions
extension ViewController {
  @objc func textFieldEditingChanged(_ sender: UITextField) {
    print("Extra - textFieldEditingChanged: \(sender.text)")
  }
}


