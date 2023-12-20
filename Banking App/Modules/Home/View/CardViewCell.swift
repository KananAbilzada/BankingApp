//
//  CardViewCell.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import UIKit

class CardViewCell: UICollectionViewCell {
   var card: CardModel? {
      didSet {
         cardView.setCardNumber(card?.pan ?? "")
         cardView.setCardUser(card?.holdername ?? "")
         cardView.setValidDate(card?.expirationDate ?? "")
      }
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupUI()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupUI()
   }
   
   private lazy var cardView: CardView = {
      let view = CardView()
      view.translatesAutoresizingMaskIntoConstraints = false
      
      return view
   }()
   
   private func setupUI() {
      // Set up your card's appearance here
      layer.cornerRadius = 10
      layer.masksToBounds = true
      
      addSubview(cardView)
      
      cardView.backgroundColor = .color(hex: "#0b9b53")
      
      NSLayoutConstraint.activate([
         cardView.topAnchor.constraint(equalTo: topAnchor),
         cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
         cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
         cardView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
   }
}
