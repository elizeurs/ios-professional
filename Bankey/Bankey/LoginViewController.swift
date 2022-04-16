//
//  ViewController.swift
//  Bankey
//
//  Created by Elizeu RS on 20/03/22.
//

import UIKit

class LoginViewController: UIViewController {
  
  let loginView = LoginView()
  let signInButton = UIButton(type: .system)
  let errorMessageLabel = UILabel()
  
  var username: String? {
    return loginView.usernameTextField.text
  }
  
  var password: String? {
    return loginView.passwordTextField.text
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension LoginViewController {
  private func style() {
    loginView.translatesAutoresizingMaskIntoConstraints = false
    
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    signInButton.configuration = .filled()
    signInButton.configuration?.imagePadding = 8 // for indicator spacing
    signInButton.setTitle("Sign In", for: [])
    signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    
    errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    errorMessageLabel.textAlignment = .center
    errorMessageLabel.textColor = .systemRed
    errorMessageLabel.numberOfLines = 0
//    errorMessageLabel.text = "Error failure"
    errorMessageLabel.isHidden = true
  }
  
  private func layout() {
    view.addSubview(loginView)
    view.addSubview(signInButton)
    view.addSubview(errorMessageLabel)
    
    // this sets isActive to true for all constraints contained within.
    // loginView
    NSLayoutConstraint.activate([
      loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
    ])
    
    // button
    NSLayoutConstraint.activate([
      signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
      signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ])
    
    // errorLabel
    NSLayoutConstraint.activate([
      errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
      errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
      errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
    ])
  }
}

// MARK: Actions
extension LoginViewController {
  @objc func signInTapped(sender: UIButton) {
    errorMessageLabel.isHidden = true
    login()
  }
  
  private func login() {
    guard let username = username, let  password = password else {
      // message to  myself
      assertionFailure("Username / password should never be nil")
      return
    }
    
    if  username.isEmpty || password.isEmpty {
      configureView(withMessage: "Username / password cannot be blank")
      return
    }
    
    if username == "Kevin" && password == "Welcome" {
      signInButton.configuration?.showsActivityIndicator = true
    } else {
      configureView(withMessage: "Inconrrect username / password")
    }
  }
  
  private func configureView(withMessage message: String) {
    errorMessageLabel.isHidden = false
    errorMessageLabel.text = message
  }
}
