//
//  UIResponder+Utils.swift
//  Password
//
//  Created by Elizeu RS on 09/07/22.
//

import UIKit

extension UIResponder {
  
  private struct Static {
    static weak var responder: UIResponder?
  }
  
  /// finds the current  first  responder
  /// - returns: the current uiresponder if it exists
  static func currentFirst() -> UIResponder? {
    Static.responder = nil
    UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
    return Static.responder
  }
  
  @objc private func _trap() {
    Static.responder = self
  }
}
