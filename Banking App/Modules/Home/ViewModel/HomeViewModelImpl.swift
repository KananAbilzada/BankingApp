//
//  HomeViewModelImpl.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import Foundation
import Combine

protocol HomeViewModel: AnyObject {
   func logout()
   
   var showLogin: Bool { get set }
}

class HomeViewModelImpl: HomeViewModel, ObservableObject {
   // MARK: - Properties
   @Published var showLogin: Bool = false
   
   var accountManager: AccountManager
   init(accountManager: AccountManager = AccountManagerImpl()) {
      self.accountManager = accountManager
   }
}

extension HomeViewModelImpl {
   func logout() {
      accountManager.logout()
      
      showLogin = true
   }
}
