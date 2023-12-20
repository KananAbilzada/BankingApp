//
//  Validator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import Foundation

protocol Validator {
   func isEmpty(field: String) -> Bool
   func isCorrectMinAndMax(min: Int, max: Int, value: String) -> Bool
   func isValidEmail(with email: String) -> Bool
   func isValidDate(in string: String, format: String) -> Bool
}

struct ValidatorImpl: Validator {
   func isEmpty(field: String) -> Bool {
      return field.isEmpty
   }
   
   func isCorrectMinAndMax(min: Int, max: Int, value: String) -> Bool {
      return value.count >= min && value.count <= max
   }
   
   func isValidEmail(with email: String) -> Bool {
      let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
      let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
      return emailPredicate.evaluate(with: email)
   }
   
   func isValidDate(in string: String, format: String = "dd-MM-yyyy") -> Bool {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = format

       if let date = dateFormatter.date(from: string) {
           // If the conversion is successful, the string contains a valid date
           print("Found date: \(date)")
           return true
       } else {
           // If the conversion fails, the string does not contain a valid date
           print("No date found in the string")
           return false
       }
   }
}
