//
//  AccountModel.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import Foundation

struct AccountModel: Codable {
   let username: String
   let email: String
   let password: String
   let birthday: String
   let isActive: Bool
}

// MARK: - Hashable
extension AccountModel: Hashable {
   static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
      return lhs.email == rhs.email
   }
}
