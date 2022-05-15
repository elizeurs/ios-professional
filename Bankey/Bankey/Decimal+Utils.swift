//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Elizeu RS on 07/05/22.
//

import Foundation

extension Decimal {
  var doubleValue: Double {
    return NSDecimalNumber(decimal: self).doubleValue
  }
}
