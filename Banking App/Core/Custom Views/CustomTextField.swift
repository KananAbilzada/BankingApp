//
//  CustomTextField.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import UIKit

class CustomTextFieldView: UIView {
   // MARK: - Views
   private lazy var stackView: UIStackView = {
      let stackView          = UIStackView(frame: .zero)
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.distribution = .fill
      stackView.spacing      = 10
      stackView.axis         = .vertical
      stackView.alignment    = .leading
      
      return stackView
   }()
   
   private lazy var errorLabel: UILabel = {
      let label = UILabel(frame: .zero)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "Has Error"
      label.textColor = .red
      label.numberOfLines = 0
      label.textAlignment = .left
      label.isHidden = true
      
      return label
   }()

   lazy var titleLabel: UILabel = {
      let label = UILabel(frame: .zero)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .black
      label.textAlignment = .left
      
      return label
   }()
   
   lazy var textField: UITextField = {
      let textField                                       = UITextField(frame: .zero)
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.borderStyle                               = .none
      textField.delegate                                  = self
      textField.textColor                                 = UIColor.color(hex: "#2D3A4D")
      textField.backgroundColor                           = UIColor.color(hex: "#f8f8f8")
      textField.layer.borderWidth                         = 1
      textField.layer.borderColor                         = UIColor.color(hex: "#EBEDF1").cgColor
      textField.layer.cornerRadius                        = 12
      textField.autocapitalizationType                    = .none
      
      return textField
   }()
   
   // MARK: - Properties
   var maxSize: Int? = nil
   
   var observeTextFieldFocus: (() -> Void)?
   var handleTextFieldValue: ((_ value: String) -> ())?
   var rightImageClickHandler: (() -> Void)?
   var leftImageClickHandler: (() -> Void)?
   
   @IBInspectable var rightImage : UIImage? {
      didSet {
         updateRightView()
      }
   }
   
   @IBInspectable var rightPadding : CGFloat = 16 {
      didSet {
         updateRightView()
      }
   }
   
   @IBInspectable var leftImage : UIImage? {
      didSet {
         updateLeftView()
      }
   }
   
   @IBInspectable var leftPadding : CGFloat = 16 {
      didSet {
         updateLeftView()
      }
   }
   
   // MARK: - Init Methods
   override public init(frame: CGRect) {
      super.init(frame: frame)
      
      addViews()
      applyStyles()
   }
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      addViews()
      applyStyles()
   }
   
   // MARK: - Layout
   override public func layoutSubviews() {
      super.layoutSubviews()
   
      NSLayoutConstraint.activate([
         stackView.topAnchor.constraint(equalTo: self.topAnchor),
         stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
         stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
         stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
         titleLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
         titleLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
         
//         textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
         textField.leftAnchor.constraint(equalTo: stackView.leftAnchor),
         textField.rightAnchor.constraint(equalTo: stackView.rightAnchor),
         textField.heightAnchor.constraint(equalToConstant: 52),
      ])
   }
   
   // MARK: - Setup UI
   private func addViews() {
      stackView.addArrangedSubview(titleLabel)
      stackView.addArrangedSubview(textField)
      stackView.addArrangedSubview(errorLabel)
   
      self.addSubview(stackView)
   }
   
   private func applyStyles() {
      applyDefaultPadding()
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(anyIconsClicked))
      stackView.addGestureRecognizer(tapGesture)
      
   }
   
   // MARK: - UI Changes
   func updateRightView() {
      if let image = rightImage {
         textField.rightViewMode = .always
         
         // assigning image
         let imageView = UIImageView(frame: CGRect(x: rightPadding, y: 0, width: 20, height: 20))
         imageView.image = image
         
         let width = rightPadding + 20
         
         let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20)) // has 5 point higher in width in imageView
         view.addSubview(imageView)
         imageView.center = view.center
         
         /// add gesture
         let rightImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightImageClicked))
         view.addGestureRecognizer(rightImageTapGesture)
         
         textField.rightView = view
         
      } else {
         applyDefaultPadding()
      }
   }
   
   func updateLeftView() {
      if let image = leftImage {
         textField.leftViewMode = .always
         
         // assigning image
         let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
         imageView.image = image
         
         let width = leftPadding + 20

         let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20)) // has 5 point higher in width in imageView
         view.addSubview(imageView)
         
         imageView.center = view.center
         
         textField.leftView = view
         
      } else {
         // image is nill
         //         leftViewMode = .never
         applyDefaultPadding()
      }
   }
   
   private func applyDefaultPadding() {
      let paddingWidth = 16
      let view         = UIView(frame: CGRect(x: 0, y: 0, width: paddingWidth, height: 20))
      
      if rightImage == nil {
         textField.rightViewMode = .always
         textField.rightView     = view
      }
      
      if leftImage == nil {
         textField.leftViewMode = .always
         textField.leftView     = view
      }
      
   }
   
   // MARK: - User Interactions
   @objc func anyIconsClicked() {
      /// show textfield when any icon clicked
      textField.becomeFirstResponder()
   }
   
   @objc private func rightImageClicked() {
      self.rightImageClickHandler?()
   }
   
   @objc private func leftImageClicked() {
      self.leftImageClickHandler?()
   }
}


extension CustomTextFieldView : UITextFieldDelegate {
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      self.removeAllErrors()
      
      guard let maxCharacterCount = maxSize else { return true }
      
      if textField.text != "" || string != "", var text = textField.text {
         text = text.filter({ !$0.isWhitespace })
         
         if textField.text!.count > maxCharacterCount {
            let currentString: NSString = textField.text! as NSString
            
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxCharacterCount
         }
         
         return true
      }
      
      return true
   }

   func textFieldDidBeginEditing(_ textField: UITextField) {
      observeTextFieldFocus?()
   }
   
   func textFieldDidChangeSelection(_ textField: UITextField) {
      self.handleTextFieldValue?(textField.text!)

   }
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      print("textFieldShouldBeginEditing")
      
      return true
   }
   
}

extension CustomTextFieldView {
   func showError(message: String) {
      self.textField.showError()
      self.errorLabel.text = message
      
      UIView.animate(withDuration: 0.2) {
         self.errorLabel.isHidden = false
      }
   }
   
   func removeAllErrors() {
      self.textField.removeErrors()
      
      if !self.errorLabel.isHidden {
         UIView.animate(withDuration: 0.4) {
            self.errorLabel.isHidden = true
         }
      }
      
   }
}

