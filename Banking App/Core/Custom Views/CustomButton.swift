//
//  CustomButton.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import UIKit

class CustomButton: UIButton {
   
   // MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupButton()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupButton()
   }
   
   // MARK: - Customization Methods
   
   private func setupButton() {
      // Customize button appearance here, such as setting default colors, fonts, etc.
      setTitleColor(.white, for: .normal)
      backgroundColor = .blue
      layer.cornerRadius = 8.0
      translatesAutoresizingMaskIntoConstraints = false
   }
   
   // MARK: - Public Methods
   
   func setButtonTitle(_ title: String) {
      setTitle(title, for: .normal)
   }
   
   func setButtonBackgroundColor(_ color: UIColor) {
      backgroundColor = color
   }
}
