//
//  PasswordCriteria.swift
//  Password
//
//  Created by Elizeu RS on 04/07/22.
//

import Foundation

struct PasswordCriteria {
  static func lengthCriteriaMet(_ text: String) -> Bool {
    text.count >= 8 && text.count <= 32
  }
  
  static func noSpaceCriteria(_ text: String) -> Bool {
    text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
  }
  
  static func lengthAndNoSpaceMet(_ text: String) -> Bool {
    lengthCriteriaMet(text) && noSpaceCriteria(text)
  }
  
  static func uppercaseMet(_ text: String) -> Bool {
    text.range(of: "[A-Z]+", options: .regularExpression) != nil
  }
  
  static func lowercaseMet(_ text: String) -> Bool {
    text.range(of: "[a-z]+", options: .regularExpression) != nil
  }
  
  static func digitMet(_ text: String) -> Bool {
    text.range(of: "[0-9]+", options: .regularExpression) != nil
  }
  
  static func specialCharacterMet(_ text: String) -> Bool {
    // regex escaped @:?!()$#,.\/
    return text.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil
  }
}
