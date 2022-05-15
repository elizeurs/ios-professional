//
//  AppDelegate.swift
//  Bankey
//
//  Created by Elizeu RS on 20/03/22.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
//  var hasOnboarded = false
  
  let loginViewController = LoginViewController()
  let onboardingViewController = OnboardingContainerViewController()
//  let dummyViewController = DummyViewController()
  let mainViewController = MainViewController()
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    loginViewController.delegate = self
    onboardingViewController.delegate = self
    
    registerForNotifications()
    
//    dummyViewController.logoutDelegate = self
//    window?.rootViewController = mainViewController
//    window?.rootViewController = loginViewController
//    window?.rootViewController = AccountSummaryViewController()
//    window?.rootViewController = onboardingContainerViewController
    
//    mainViewController.selectedIndex = 2
    
//    let vc = mainViewController
//    vc.setStatusBar()
    
//    UINavigationBar.appearance().isTranslucent = false
//    UINavigationBar.appearance().backgroundColor = appColor
//
//    window?.rootViewController = vc
    
  displayLogin()
    return true
  }
  
  private func registerForNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
  }
  
  private func displayLogin() {
    setRootViewController(loginViewController)
  }
  
  private func displayNextScreen() {
    if LocalState.hasOnboarded {
      prepMainView()
      setRootViewController(mainViewController)
    } else {
      setRootViewController(onboardingViewController)
    }
  }
  
  private func prepMainView() {
    mainViewController.setStatusBar()
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().backgroundColor = appColor
  }
}

extension AppDelegate {
  func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = vc
      self.window?.makeKeyAndVisible()
      return
    }
    
    window.rootViewController = vc
    window.makeKeyAndVisible()
    UIView.transition(with: window,
                      duration: 0.3,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }
}


extension AppDelegate: LoginViewControllerDelegate {
  func didLogin() {
    displayNextScreen()
//    print("foo - Did login")
//    window?.rootViewController = onboardingContainerViewController
//    if hasOnboarded {
//    if LocalState.hasOnboarded {
//      setRootViewController(mainViewController)
//    } else {
//      setRootViewController(onboardingContainerViewController)
//    }
  }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
  func didFinishOnboarding() {
    // TODO: Display home screen
//    print("foo - Did onboard")
//    hasOnboarded = true
    LocalState.hasOnboarded = true
    prepMainView()
    setRootViewController(mainViewController)
  }
}

extension AppDelegate: LogoutDelegate {
  @objc func didLogout() {
    setRootViewController(loginViewController)
  }
}


