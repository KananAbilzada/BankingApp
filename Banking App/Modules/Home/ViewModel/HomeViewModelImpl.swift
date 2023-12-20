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
   func getCards()
   var showLogin: Bool { get set }
   
   var cards: [CardModel] { get set }
   func createNewCard(name: String, balance: Float, expirationDate: String, pan: String, cvv: String)
}

class HomeViewModelImpl: HomeViewModel, ObservableObject {
   // MARK: - Properties
   @Published var showLogin: Bool = false
   @Published var cards: [CardModel] = .init()
   
   var accountManager: AccountManager
   init(accountManager: AccountManager = AccountManagerImpl.shared) {
      self.accountManager = accountManager
   }
   
   deinit {
      print("Deinited: HomeViewModelImpl")
   }
}

extension HomeViewModelImpl {
   func logout() {
      accountManager.logout()
      
      showLogin = true
   }
   
   func getCards() {
      self.cards = accountManager.getCards()
   }
   
   func createNewCard(name: String, balance: Float, expirationDate: String, pan: String, cvv: String) {
      let randomNumber = CardGenerator.generateRandomCardNumber()
      
      let newCard: CardModel = .init(
         holdername: name, balance: balance,
         expirationDate: expirationDate, pan: pan,
         cvv: cvv
      )

      accountManager.saveCard(new: newCard)
      
      self.cards = accountManager.getCards()
   }
}
