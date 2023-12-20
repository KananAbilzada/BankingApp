//
//  CardView.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import UIKit

class CardView: UIView {
   
   // MARK: - Initialization
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupUI()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupUI()
   }
   
   // MARK: - Views
   private lazy var wifiImage: UIImageView = {
      let originalImage = UIImage(named: ImageNames.wifi.rawValue)
      let templateImage = originalImage?.withRenderingMode(.alwaysTemplate)
      var imageView = UIImageView(image: templateImage)
      imageView.tintColor = UIColor.white
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      let angleInRadians = CGFloat.pi / 2
      imageView.transform = CGAffineTransform(rotationAngle: angleInRadians)
      
      return imageView
   }()
   
   private lazy var cardNumber: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .black
      label.textAlignment = .left
      label.textColor = .white
      label.font = .boldSystemFont(ofSize: 20)
      
      return label
   }()
   
   private lazy var usernameTitle: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .white
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 20)
      
      return label
   }()
   
   private lazy var validDateTitle: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .white
      label.textAlignment = .left
      label.font = .boldSystemFont(ofSize: 14)
      
      return label
   }()
   
   // MARK: - Setup
   private func setupUI() {
      translatesAutoresizingMaskIntoConstraints = false
      layer.cornerRadius = 20
      backgroundColor = .color(hex: "#169d54")
      
      self.addSubview(wifiImage)
      self.addSubview(cardNumber)
      self.addSubview(usernameTitle)
      self.addSubview(validDateTitle)
      
      setConstraints()
   }
   
   func setCardNumber(_ number: String) {
      cardNumber.text = number
   }
   
   func setCardUser(_ name: String) {
      usernameTitle.text = name
   }
   
   func setValidDate(_ date: String) {
      validDateTitle.text = date
   }
   
   func setConstraints() {
      NSLayoutConstraint.activate([
         wifiImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
         wifiImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
         wifiImage.widthAnchor.constraint(equalToConstant: 20),
         wifiImage.heightAnchor.constraint(equalToConstant: 20),
         
         cardNumber.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         cardNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         cardNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
         
         usernameTitle.topAnchor.constraint(equalTo: cardNumber.bottomAnchor, constant: 20),
         usernameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         
         validDateTitle.topAnchor.constraint(equalTo: usernameTitle.bottomAnchor, constant: 20),
         validDateTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      ])
   }
}

