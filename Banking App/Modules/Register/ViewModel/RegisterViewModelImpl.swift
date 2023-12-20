//
//  RegisterViewModelImpl.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import Foundation
import Combine

class RegisterViewModelImpl: RegisterViewModel, ObservableObject {
   // MARK: - Properties
   @Published var successRegister: Bool = false
   @Published var showMessage: String = ""
   
   @Published var errors: [Fields: String] = .init()
   enum Fields {
      case username
      case email
      case password
      case birthday
   }
   
   var validator: Validator
   var accountManager: AccountManager
   
   init(
      validator: Validator = ValidatorImpl(),
      accountManager: AccountManager = AccountManagerImpl.shared
   ) {
      self.validator = validator
      self.accountManager = accountManager
   }
   
   deinit {
      print("Deinited: RegisterViewModelImpl")
   }
}

// MARK: - Validation
extension RegisterViewModelImpl {
   func checkFields(username: String, email: String, password: String, birthday: String) {
      errors.removeAll()
      
      if !validator.isCorrectMinAndMax(min: 3, max: 18, value: username) {
         errors[.username] = "Username is wrong"
      }
      
      if !validator.isValidEmail(with: email) {
         errors[.email] = "Email is wrong"
      }
      
      if !validator.isCorrectMinAndMax(min: 3, max: 18, value: password) {
         errors[.password] = "Password is wrong"
      }
      
      if !validator.isValidDate(in: birthday, format: "dd-MM-yyyy") {
         errors[.birthday] = "Birthday is wrong"
      }
      
      if errors.isEmpty {
         /// check isset in table or not
         if !self.checkIssetInTable(email: email) {
            /// save to saved account table
            self.saveToAccounts(
               name: username,
               email: email,
               password: password,
               birthday: birthday
            )
         } else {
            errors[.email] = "This email has been registered!"
         }
      }
   }
}

// MARK: - Storage
extension RegisterViewModelImpl {
   func checkIssetInTable(email: String) -> Bool {
      return accountManager.issetUser(with: email)
   }
   
   /// save in temporary table
   func saveToAccounts(
      name: String, email: String,
      password: String, birthday: String
   ) {
      accountManager.saveUser(
         new: .init(
            username: name,
            email: email,
            password: password,
            birthday: birthday,
            isActive: true
         )
      )
      
      accountManager.saveLogin()
      self.successRegister = true
   }
}
