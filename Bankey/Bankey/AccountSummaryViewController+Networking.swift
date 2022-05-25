//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Elizeu RS on 24/05/22.
//

import Foundation
import UIKit

enum NetworkError: Error {
  case serverError
  case DecodingError
}

struct Profile: Codable {
  let id: String
  let firstName: String
  let lastName: String
  
  enum CodingKeys: String, CodingKey {
  case id
  case firstName = "first_name"
  case lastName = "last_name"
  }
}

extension AccountSummaryViewController {
  func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void)  {
    let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        guard let data = data, error == nil else {
          completion(.failure(.serverError))
          return
        }
        do {let profile = try
          JSONDecoder().decode(Profile.self, from: data)
          completion(.success(profile))
        } catch {
          completion(.failure(.DecodingError))
        }
      }
    }.resume()
  }
}

struct Account: Codable {
  let id: String
  let type: AccountType
  let name: String
  let amount: Decimal
  let createDateTime: Date
}
  
extension AccountSummaryViewController {
  func fetchAccounts(forUserId userId: String, completion: @escaping(Result<[Account], NetworkError>) -> Void) {
    let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/account")!
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        guard let data = data, error == nil else {
          completion(.failure(.serverError))
          return
        }
        
        do {
          let decoder = try JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
          
          let accounts = try decoder.decode([Account].self, from: data)
          completion(.success(accounts))
        } catch {
          completion(.failure(.DecodingError))
        }
      }
    }.resume()
  }
}