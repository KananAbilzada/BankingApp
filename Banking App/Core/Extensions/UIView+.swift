//
//  UIView+.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import UIKit

extension UIView {
   func showError() {
      self.layer.borderColor     = UIColor.color(hex: "#ED5051").cgColor
      self.layer.borderWidth     = 1
      self.layer.backgroundColor = UIColor.red.cgColor.copy(alpha: 0.03)
   }
   
   func removeErrors() {
      self.backgroundColor = UIColor.color(hex: "#f8f8f8")
      self.backgroundColor = .clear
      self.layer.borderColor = UIColor.color(hex: "#EBEDF1").cgColor
   }
}
