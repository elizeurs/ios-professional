//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Elizeu RS on 17/07/22.
//

import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {
  
  var statusView: PasswordStatusView!
  var validPassword = "12345678Aa!"
  var tooShort = "123Aa!"
  
  override func setUp() {
    super.setUp()
    statusView = PasswordStatusView()
    statusView.shouldResetCriteria = true // inline
  }
  
  /*
  if shouldResetCriteria {
    // inline validation (✅ or ⚪️)
  } else {
    ...
  }
   */
  
  func testValidPassword() throws {
    statusView.updateDisplay(validPassword)
    XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
    XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
  }
  
  func testTooShort() throws {
    statusView.updateDisplay(tooShort)
    XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
    XCTAssertTrue(statusView.lengthCriteriaView.isResetImage) // ⚪️
  }
}


class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {
  
  var statusView: PasswordStatusView!
  let validPassword = "12345678Aa!"
  let tooShort = "123Aa!"
  
  override func setUp() {
    super.setUp()
    statusView = PasswordStatusView()
    statusView.shouldResetCriteria = false // loss of focus
  }
  
  /*
   if shouldResetCriteria {
   ...
   } else {
   // Focus lost (✅ or X)
   }
   */
  
  func testValidPassword() throws {
    statusView.updateDisplay(validPassword)
    // 🕹 Ready Player1
    XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
    XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    
  }
  
  func testTooShort() throws {
    statusView.updateDisplay(tooShort)
    // 🕹 Ready Player!
    XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
    XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage) // X
  }
}

class PasswordStatusViewTests_Validate_Three_of_Four: XCTestCase {
  
  var statusView: PasswordStatusView!
  let twoOfFour = "12345678A"
  let threeOfFour = "12345678Aa"
  let fourOfFour = "12345678Aa!"
  
  // Verify is valid if three of four criteria met
  override func setUp() {
    super.setUp()
    statusView = PasswordStatusView()
  }
  
  func testTwoOfFour() throws {
    XCTAssertFalse(statusView.validate(twoOfFour))
  }
  
  func testThreeOfFour() throws {
    XCTAssertTrue(statusView.validate(threeOfFour))
  }
  
  func testFourOfFour() throws {
    XCTAssertTrue(statusView.validate(fourOfFour))
  }
}
