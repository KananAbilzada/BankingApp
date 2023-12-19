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
   func issetUser(with email: String) -> Bool
   func saveUser(new user: AccountModel)
   func getUsers() -> [AccountModel]
   func getUser(with email: String) -> AccountModel?
   func logout()
}


struct AccountManagerImpl: AccountManager {
   var jsonHelper: JSONHelperProtocol
   init(jsonHelper: JSONHelperProtocol = JSONHelper()) {
      self.jsonHelper = jsonHelper
   }
   
   func hasLogin() -> Bool {
      return UserDefaults.standard.bool(forKey: "isLoggedIn")
   }
   
   func saveLogin() {
      UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
   }
   
   func issetUser(with email: String) -> Bool {
      if let currentUsers = UserDefaults.standard.data(forKey: "users_table") {
         guard
            let allUsers = jsonHelper.decode(jsonData: currentUsers, type: [AccountModel].self)
         else { return false }
         
         return allUsers.first(where: { $0.email == email }) != nil
      }
      
      return false
   }
   
   func saveUser(new user: AccountModel) {
      var currentUsers = self.getUsers()
      currentUsers.append(user)
      
      guard
         let data = jsonHelper.encode(encodable: currentUsers)
      else { return }
      
      UserDefaults.standard.setValue(data, forKey: "users_table")
   }
   
   func getUsers() -> [AccountModel] {
      if let currentUsers = UserDefaults.standard.data(forKey: "users_table") {
         print("currentUsers: ", currentUsers)
         
         guard
            let allUsers = jsonHelper.decode(jsonData: currentUsers, type: [AccountModel].self)
         else { return [] }
         
         return allUsers
      }
      
      return []
   }
   
   func getUser(with email: String) -> AccountModel? {
      let users = self.getUsers()
      
      return users.first { $0.email == email }
   }
   
   func logout() {
      UserDefaults.standard.removeObject(forKey: "isLoggedIn")
   }
}
