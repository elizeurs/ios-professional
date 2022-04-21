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
  let onboardingContainerViewController = OnboardingContainerViewController()
  let dummyViewController = DummyViewController()
  let mainViewController = MainViewController()
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    loginViewController.delegate = self
    onboardingContainerViewController.delegate = self
    dummyViewController.logoutDelegate = self
    
    window?.rootViewController = mainViewController
//    window?.rootViewController = loginViewController
//    window?.rootViewController = onboardingContainerViewController
    
    mainViewController.selectedIndex = 2
    return true
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
//    print("foo - Did login")
//    window?.rootViewController = onboardingContainerViewController
//    if hasOnboarded {
    if LocalState.hasOnboarded {
      setRootViewController(dummyViewController)
    } else {
      setRootViewController(onboardingContainerViewController)
    }
  }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
  func didFinishOnboarding() {
    // TODO: Display home screen
//    print("foo - Did onboard")
//    hasOnboarded = true
    LocalState.hasOnboarded = true
    setRootViewController(dummyViewController)
  }
}

extension AppDelegate: LogoutDelegate {
  func didLogout() {
    setRootViewController(loginViewController)
  }
}


