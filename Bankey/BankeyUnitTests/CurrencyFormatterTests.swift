//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Elizeu RS on 09/05/22.
//

import Foundation
import XCTest

// attribute allow access to all files in your target.
@testable import Bankey

class Test: XCTestCase {
//  var vc: ViewController!
  var formatter: CurrencyFormatter!
  
  override func setUp() {
    super.setUp()
//    vc = ViewController()
//    vc.loadViewIfNeeded()
    formatter = CurrencyFormatter()
  }
  
  func testShouldBeVisible() throws {
//    let isViewLoaded = vc.isViewLoaded
//    XCTAssertTrue(isViewLoaded)
    let result = formatter.breakIntoDollarsAndCents(929466.23)
    XCTAssertEqual(result.0, "929,466")
    XCTAssertEqual(result.1, "23")
  }
  
  // challenge: you write
  func testDollarsFormatted() throws {
    let result = formatter.dollarsFormatted(929466.23)
    XCTAssertEqual(result, "$929,466.23")
  }
  
  // challenge: you write
  func testZeroDollarsFormatted() throws {
    let result = formatter.dollarsFormatted(0.00)
    XCTAssertEqual(result, "$0.00")
  }
  
  func testDollarsFormattedWithCurrencySymbol() throws {
    let locale = Locale.current
    let currencySymbol = locale.currencySymbol!
    
    let result = formatter.dollarsFormatted(929466.23)
    print("\(currencySymbol)")
    XCTAssertEqual(result, "\(currencySymbol)929,466.23")
  }
}


