//
//  ViewController.swift
//  Bankey
//
//  Created by Elizeu RS on 20/03/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
  func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject  {
  func didLogin()
}

class LoginViewController: UIViewController {
  
  let loginView = LoginView()
  let signInButton = UIButton(type: .system)
  let errorMessageLabel = UILabel()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  
  weak var delegate: LoginViewControllerDelegate?
  
  var username: String? {
    return loginView.usernameTextField.text
  }
  
  var password: String? {
    return loginView.passwordTextField.text
  }
  
  // animation
  var leadingEdgeOnScreen: CGFloat = 16
  var leadingEdgeOffScreen: CGFloat = -1000
  
  var titleLeadingAnchor: NSLayoutConstraint?
  var subtitleLeadingAnchor: NSLayoutConstraint?

  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    signInButton.configuration?.showsActivityIndicator = false
  }
  
  // view to be fully rendered and fully put that title off screen.
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animate()
//    animate2()
  }
}

extension LoginViewController {
  private func style() {
    view.backgroundColor = .systemBackground
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.text = "Bankey"
    titleLabel.alpha = 0
    
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    subtitleLabel.textAlignment = .center
    subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    subtitleLabel.adjustsFontForContentSizeCategory = true
    subtitleLabel.numberOfLines = 0
    subtitleLabel.text = "Your premium source for all things banking!"
    subtitleLabel.alpha = 0
    
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
    view.addSubview(titleLabel)
    view.addSubview(subtitleLabel)
    view.addSubview(loginView)
    view.addSubview(signInButton)
    view.addSubview(errorMessageLabel)
    
    // this sets isActive to true for all constraints contained within.
    // title
//    NSLayoutConstraint.activate([
//      subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
//      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//    ])
    
    // title
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
      titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ])
    
    titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
    titleLeadingAnchor?.isActive = true
    
    // subtitle
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
      subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
    ])
    
    subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
    subtitleLeadingAnchor?.isActive = true
    
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
    
//    if  username.isEmpty || password.isEmpty {
//      configureView(withMessage: "Username / password cannot be blank")
//      return
//    }
    
    if username == "" && password == "" {
      signInButton.configuration?.showsActivityIndicator = true
      delegate?.didLogin()
    } else {
      configureView(withMessage: "Inconrrect username / password")
    }
  }
  
  private func configureView(withMessage message: String) {
    errorMessageLabel.isHidden = false
    errorMessageLabel.text = message
  }
}

// MARK: - Animations
extension LoginViewController {
  private func animate() {
    let duration = 2.0
    
    let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
      self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
      self.view.layoutIfNeeded()
    }
    animator1.startAnimation()
    
    let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
      self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
      self.view.layoutIfNeeded()
    }
    animator2.startAnimation(afterDelay: 1)
    
    let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
      self.titleLabel.alpha = 1
      self.subtitleLabel.alpha = 1
      self.view.layoutIfNeeded()
    }
    animator3.startAnimation(afterDelay: 1)
  }
  
//  private func animate2() {
//    let animator2 = UIViewPropertyAnimator(duration: 2, curve: .easeOut) {
//      self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
//      self.view.layoutIfNeeded()
//    }
//    animator2.startAnimation()
//  }
}

