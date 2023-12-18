//
//  LoginViewModelImpl.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import Foundation
import Combine

// MARK: - Temp Storage
var savedAccounts: [AccountModel] = .init()
/// created for just temp storage



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
   
   init(validator: Validator = ValidatorImpl()) {
      self.validator = validator
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
      if let user = savedAccounts.first(where: { $0.email == email }) {
         
         guard user.password != password else {
            self.showMessage = "Passwords not match!"
            return
         }
         
         self.successLogin = true
         
      } else {
         self.showMessage = "User not found"
      }
   }
}
