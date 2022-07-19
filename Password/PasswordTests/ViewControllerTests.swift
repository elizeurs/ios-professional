//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Elizeu RS on 18/07/22.
//

import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {
  
  var vc: ViewController!
  let validPassword = "12345678Aa!"
  let tooShort = "1234Aa!"
  
  override func setUp() {
    super.setUp()
    vc = ViewController()
  }
  
  /*
   Here we trigger those criteria blocks by entering text, clicking the  reset password button, and then checking the error label text   for the right message.
   */
  
  func testEmptyPassword() throws {
    vc.newPasswordText = ""
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
  }
  
  func testInvalidPassword() throws {
    // 🕹
    vc.newPasswordText = "🕹"
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
  }
  
  func testCriteriaNotMet() throws {
    // 🕹
    vc.newPasswordText =  tooShort
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Your password must meet the requirements below")
  }
  
  func testValidPassword() throws {
    // 🕹
    vc.newPasswordText = validPassword
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "")
  }
}

class ViewControllerTests_Confirm_Password_Validation: XCTestCase {
  
  var vc: ViewController!
  let validPassword = "12345678Aa!"
  let tooShort = "1234Aa!"
  
  override func setUp() {
    super.setUp()
    vc = ViewController()
  }
  
  func testEmptyPassword() throws {
    vc.confirmPasswordText = ""
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password.")
  }
  
  func testPasswordsMatch() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = validPassword
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
  }
  
  func testPasswordsDoNotMatch() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = tooShort
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match.")
  }
}

class ViewControllerTests_Show_Alert: XCTestCase {
  
  var vc: ViewController!
  let validPassword = "12345678Aa!"
  let tooShort = "1234Aa!"
  
  override func setUp() {
    super.setUp()
    vc = ViewController()
  }
  
  func testShowSuccess() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = validPassword
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertNotNil(vc.alert)
    XCTAssertEqual(vc.alert!.title, "Success") // Optional
  }
  
  func testShowError() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = tooShort
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertNil(vc.alert)
  }
}



