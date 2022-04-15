//
//  AppDelegate.swift
//  Bankey
//
//  Created by Elizeu RS on 20/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
//    window?.rootViewController = LoginViewController()
    window?.rootViewController = OnboardingContainerViewController()
    
    return true
  }
}

