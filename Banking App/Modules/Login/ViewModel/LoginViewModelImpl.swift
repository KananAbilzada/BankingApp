//
//  LoginViewModelImpl.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import Foundation
import Combine

class LoginViewModelImpl: LoginViewModel, ObservableObject {
   // MARK: - Properties
   @Published var successLogin: Bool = false
   @Published var showMessage: String = ""
   
   
   @Published var errors: [Fields: String] = .init()
   enum Fields {
      case email
      case password
   }
   
   var validator: Validator
   var jsonHelper: JSONHelperProtocol
   var accountManager: AccountManager
   
   init(
      validator: Validator = ValidatorImpl(),
      jsonHelper: JSONHelperProtocol = JSONHelper(),
      accountManager: AccountManager = AccountManagerImpl()
   ) {
      self.validator = validator
      self.jsonHelper = jsonHelper
      self.accountManager = accountManager
   }
}

// MARK: - Validation
extension LoginViewModelImpl {
   func checkFields(email: String, password: String) {
      errors.removeAll()
      
      if !isValidEmail(value: email) {
         errors[.email] = "Email is wrong"
      }
      
      if !isValidPassword(value: password) {
         errors[.password] = "Password is wrong"
      }
      
      if errors.isEmpty {
         self.checkIssetInTable(email: email, password: password)
      }
   }
   
   func isValidEmail(value: String) -> Bool {
      return validator.isValidEmail(with: value)
   }
   
   func isValidPassword(value: String) -> Bool {
      return validator.isCorrectMinAndMax(min: 3, max: 18, value: value)
   }
}

// MARK: - Storage
extension LoginViewModelImpl {
   func checkIssetInTable(email: String, password: String) {
      if let user = accountManager.getUser(with: email) {
         guard user.password == password else {
            self.showMessage = "Passwords not match!"
            return
         }
         
         accountManager.saveLogin()
         self.successLogin = true
      }  else {
         self.showMessage = "User not found"
      }
   }
}
