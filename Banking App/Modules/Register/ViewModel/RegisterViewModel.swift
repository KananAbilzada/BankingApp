//
//  RegisterViewModel.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import Foundation

protocol RegisterViewModel: AnyObject {
   var validator: Validator { get set }
   
   var successRegister: Bool { get set }
   
   /// for show any message  to user in viewController
   var showMessage: String { get set }
}
