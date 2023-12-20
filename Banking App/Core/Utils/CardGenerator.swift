//
//  CardGenerator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 20.12.23.
//

import Foundation

struct CardGenerator {
   static func generateRandomCardNumber() -> String {
       var cardNumber = ""

       for _ in 1...16 {
           let digit = Int.random(in: 0...9)
           cardNumber += "\(digit)"
       }

       // Format the card number with spaces
       let formattedCardNumber = cardNumber.chunked(into: 4).joined(separator: " ")

       return formattedCardNumber
   }
}

extension String {
    func chunked(into size: Int) -> [String] {
        return stride(from: 0, to: count, by: size).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
}
