//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Elizeu RS on 17/07/22.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
  
  // Boundary conditions 8-32
  func testShort() throws {
    XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
  }
  
  func testLong() throws { // 33
    // 🕹
    XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890123"))
  }
  
  func testValidShort() throws { // 8
    // 🕹
    XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
  }
  
  func testValidLong() throws { // 32
    // 🕹
    XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012"))
  }
}

class PasswordOtherCriteriaTests: XCTestCase {
  func testSpaceMet() throws {
    XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
  }
  
  func testSpaceNotMet() throws {
    XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
  }
  
  func testLengthAndSpaceMet() throws {
    XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("12345678abc"))
  }
  
  func testLengthAndSpaceNotMet() throws {
    XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1234567 8"))
  }
  
  func testUppercaseMet() throws {
    XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
  }
  
  func testUppercaseNotMet() throws {
    XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
  }
  
  func testLowercaseMet() throws {
    XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
  }
  
  func testLowercaseNotMet() throws {
    XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
  }
  
  func testDigitMet() throws {
    XCTAssertTrue(PasswordCriteria.digitMet("1"))
  }
  
  func testDigitNotMet() throws {
    XCTAssertFalse(PasswordCriteria.digitMet("a"))
  }
  
  func testSpecialCharacterMet() throws {
    XCTAssertTrue(PasswordCriteria.specialCharacterMet("@"))
  }
  
  func testSpecialCharacterNotMet() throws {
    XCTAssertFalse(PasswordCriteria.specialCharacterMet("a"))
  }
}
