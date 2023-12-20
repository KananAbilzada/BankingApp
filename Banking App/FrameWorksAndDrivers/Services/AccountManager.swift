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
   func saveCard(new user: CardModel)
   func logout()
   func getCards() -> [CardModel]
}


struct AccountManagerImpl: AccountManager {
   static let shared = AccountManagerImpl()
   
   var jsonHelper: JSONHelperProtocol
   private init(jsonHelper: JSONHelperProtocol = JSONHelper()) {
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
   
   func saveCard(new user: CardModel) {
      var currentCards = self.getCards()
      currentCards.append(user)
      
      guard
         let data = jsonHelper.encode(encodable: currentCards)
      else { return }
      
      UserDefaults.standard.setValue(data, forKey: "cards_table")
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
   
   func getCards() -> [CardModel] {
      if let currentUsers = UserDefaults.standard.data(forKey: "cards_table") {
         print("currentUsers: ", currentUsers)
         
         guard
            let allCards = jsonHelper.decode(jsonData: currentUsers, type: [CardModel].self)
         else { return [] }
         
         return allCards
      }
      
      return []
   }
   
   func logout() {
      UserDefaults.standard.removeObject(forKey: "isLoggedIn")
   }
}
