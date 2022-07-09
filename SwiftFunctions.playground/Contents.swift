import UIKit

typealias longComplicatedExpression = (Int) -> Bool

func hasAnyMatches(list: [Int], condition: longComplicatedExpression) -> Bool {
  for item in list {
    if condition(item) {
      return true
    }
  }
  return false
}

func lessThanTen(number: Int) -> Bool {
  return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

func betweenOneAndTen(num: Int) -> Bool {
  return num <= 10 && num >= 1
}

hasAnyMatches(list: [2,3,4], condition: betweenOneAndTen) // true
hasAnyMatches(list: [0,11], condition: betweenOneAndTen) // false
hasAnyMatches(list: [1,11], condition: betweenOneAndTen) // true
hasAnyMatches(list: [0,10], condition: betweenOneAndTen) // true
