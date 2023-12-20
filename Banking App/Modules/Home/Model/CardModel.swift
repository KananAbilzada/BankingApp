//
//  CardModel.swift
//  Banking App
//
//  Created by Kanan Abilzada on 20.12.23.
//

import Foundation

struct CardModel: Codable {
   let holdername: String
   let balance: Float
   let expirationDate: String
   let pan: String
   let cvv: String
}

// MARK: - Hashable
extension CardModel: Hashable {
   static func == (lhs: CardModel, rhs: CardModel) -> Bool {
      return lhs.pan == rhs.pan
   }
}
