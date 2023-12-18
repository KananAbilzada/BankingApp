//
//  AccountModel.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import Foundation

struct AccountModel {
   let email: String
   let password: String
   let isActive: Bool
}

// MARK: - Hashable
extension AccountModel: Hashable {
   static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
      return lhs.email == rhs.email
   }
}
