//
//  AccountManager.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import Foundation

protocol AccountManager {
   func hasLogin() -> Bool
   func saveLogin()
}


struct AccountManagerImpl: AccountManager {
   func hasLogin() -> Bool {
      return UserDefaults.standard.bool(forKey: "isLoggedIn")
   }
   
   func saveLogin() {
      UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
   }
}
