//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Elizeu RS on 21/04/22.
//

import UIKit

extension UIViewController {
  func setStatusBar() {
    let statusBarSize = UIApplication.shared.statusBarFrame.size // deprecated, but ok.
    let frame = CGRect(origin: .zero, size: statusBarSize)
    let statusbarView = UIView(frame: frame)
    
    statusbarView.backgroundColor = appColor
    view.addSubview(statusbarView)
    
  }
  
  func setTabBarImage(imageName: String, title: String) {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: imageName, withConfiguration: configuration)
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
  }
}
