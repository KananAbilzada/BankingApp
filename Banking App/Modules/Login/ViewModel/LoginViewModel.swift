//
//  LoginViewModel.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import Foundation

protocol LoginViewModel: AnyObject {
   var validator: Validator { get set }
   var errors: [Fields: String] { get set }
   
   var successLogin: Bool { get set }
   
   /// for show any message  to user in viewController
   var showMessage: String { get set }
   
   func isValidEmail(value: String) -> Bool
   func isValidPassword(value: String) -> Bool
}
