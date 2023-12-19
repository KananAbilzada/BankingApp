//
//  ActionButton.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import UIKit

class ActionButton: UIButton {
   
   // MARK: - Initialization
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupButton()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupButton()
   }
   
   // MARK: - Views
   
   lazy var title: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .black
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 12)
      
      return label
   }()
   
   lazy var iconView: UIImageView = {
      var imageView = UIImageView()
      imageView.tintColor = UIColor.white
      imageView.translatesAutoresizingMaskIntoConstraints = false
      
      return imageView
   }()
   
   private lazy var backgroundView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      view.layer.cornerRadius = 12
      view.layer.shadowColor = UIColor.black.cgColor
      view.layer.shadowOpacity = 0.2
      view.layer.shadowOffset = .init(width: 0, height: 1)
      view.layer.shadowRadius = 1
   
      return view
      
   }()
   
   
   // MARK: - Customization Methods
   
   private func setupButton() {
      // Customize button appearance here, such as setting default colors, fonts, etc.
      translatesAutoresizingMaskIntoConstraints = false
      
      self.addSubview(backgroundView)
      self.addSubview(title)
      backgroundView.addSubview(iconView)
      
      setupBackground()
      
      setConstraints()
   }
   
   private func setupBackground() {
      
   }
   
   func setConstraints() {
      NSLayoutConstraint.activate([
         backgroundView.topAnchor.constraint(equalTo: topAnchor),
         backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
         backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
         backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
         backgroundView.widthAnchor.constraint(equalToConstant: 70),
         backgroundView.heightAnchor.constraint(equalToConstant: 70),
        
         iconView.widthAnchor.constraint(equalToConstant: 20),
         iconView.heightAnchor.constraint(equalToConstant: 20),
         iconView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
         iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
         
         title.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
         title.centerXAnchor.constraint(equalTo: centerXAnchor),
      ])
      
   }
}
