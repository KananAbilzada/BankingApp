//
//  RegisterViewController.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
   // MARK: - Properties
   var coordinator: RegisterCoordinator?
   private var cancellabes: Set<AnyCancellable> = .init()
   private var viewModel = RegisterViewModelImpl()
   
   // MARK: - Views
   private lazy var usernameField: CustomTextFieldView = .init()
   private lazy var emailField: CustomTextFieldView = .init()
   private lazy var passwordField: CustomTextFieldView = .init()
   private lazy var birthdayField: CustomTextFieldView = .init()
   
   private lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
   }()
   
   private lazy var scrollViewContainer: UIStackView = {
      let view = UIStackView()
      view.axis = .vertical
      view.spacing = 20
      
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   private lazy var fieldsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .vertical
      stackView.spacing = 15
      stackView.distribution = .fill
      
      return stackView
   }()
   
   private lazy var headerImage: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.image = .init(named: ImageNames.registerBackground.rawValue)
      imageView.contentMode = .scaleAspectFit
      
      return imageView
   }()
   
   private lazy var registerButton: CustomButton = {
      let button = CustomButton()
      button.setButtonTitle("Confirm")
      button.setButtonBackgroundColor(.systemBlue)
      
      return button
   }()
   
   // MARK: - Main methods
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      title = "Registration"
      
      setupUI()
      subscribeToViewModel()
   }
   
   deinit {
      print("Deinited: RegisterViewController")
   }
}

// MARK: - Setup
extension RegisterViewController {
   private func setupUI() {
      view.backgroundColor = .white
      
      setupScrollView()
      
      scrollViewContainer.addArrangedSubview(headerImage)
      
      setupFields()
      setupButton()
      setConstraints()
   }
   
   private func setupScrollView() {
      view.addSubview(scrollView)
      scrollView.addSubview(scrollViewContainer)
      
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      
      scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
      scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
      scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
      scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
      // this is important for scrolling
      scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
   }
   
   private func setupButton() {
      scrollViewContainer.addArrangedSubview(registerButton)
      
      self.registerButton.addAction(UIAction(handler: { [weak self] action in
         guard let self else { return }
         /// validate fields and continue
         self.viewModel.checkFields(
            username: self.usernameField.textField.text!,
            email: self.emailField.textField.text!,
            password: self.passwordField.textField.text!,
            birthday: self.birthdayField.textField.text!
         )
      }), for: .touchUpInside)
   }
   
   private func setupFields() {
      usernameField.titleLabel.text = "Username"
      usernameField.leftImage = .init(named: ImageNames.profile.rawValue)
      usernameField.textField.placeholder = "Kanan"
      
      emailField.titleLabel.text = "Email"
      emailField.textField.keyboardType = .emailAddress
      emailField.leftImage = .init(named: ImageNames.email.rawValue)
      emailField.textField.placeholder = "example@gmail.com"
      
      passwordField.titleLabel.text = "Password"
      passwordField.textField.keyboardType = .default
      passwordField.textField.isSecureTextEntry = true
      passwordField.leftImage = .init(named: ImageNames.password.rawValue)
      passwordField.textField.placeholder = "******"
      
      birthdayField.titleLabel.text = "Birthday"
      birthdayField.leftImage = .init(named: ImageNames.birthday.rawValue)
      birthdayField.textField.placeholder = "12.08.2012"
      
      fieldsStackView.addArrangedSubview(usernameField)
      fieldsStackView.addArrangedSubview(emailField)
      fieldsStackView.addArrangedSubview(passwordField)
      fieldsStackView.addArrangedSubview(birthdayField)
      
      scrollViewContainer.addArrangedSubview(fieldsStackView)
   }
   
   private func setConstraints() {
      let height = UIScreen.main.bounds.height
      
      NSLayoutConstraint.activate([
         headerImage.centerXAnchor.constraint(equalTo: scrollViewContainer.centerXAnchor),
         headerImage.widthAnchor.constraint(equalToConstant: 300),
         headerImage.heightAnchor.constraint(equalToConstant: 200),
         headerImage.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor, constant: height / 30),
         
         fieldsStackView.centerXAnchor.constraint(equalTo: scrollViewContainer.centerXAnchor),
         fieldsStackView.topAnchor.constraint(equalTo: headerImage.bottomAnchor),
         fieldsStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20),
         fieldsStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -20),
         
         registerButton.centerXAnchor.constraint(equalTo: scrollViewContainer.centerXAnchor),
         registerButton.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20),
         registerButton.heightAnchor.constraint(equalToConstant: 60),
         registerButton.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -20),
      ])
      
   }
}

// MARK: - Observe ViewModel
extension RegisterViewController {
   private func subscribeToViewModel() {
      /// validation of submit button clicked to continue
      viewModel.$errors
         .filter { !$0.isEmpty }
         .sink { [weak self] errors in
            guard let self else { return }
            print("show errors \(errors)")
            
            errors.forEach { key, value in
               if key == .username {
                  self.usernameField.showError(message: value)
               }
               
               if key == .email {
                  self.emailField.showError(message: value)
               }
               
               if key == .password {
                  self.passwordField.showError(message: value)
               }
               
               if key == .birthday {
                  self.birthdayField.showError(message: value)
               }
            }
         }
         .store(in: &cancellabes)
      
      /// show any message to userr
      viewModel.$showMessage
         .dropFirst()
         .sink { [weak self] message in
            guard let self else { return }
            
            self.informationAlert(title: "Attention!", message: message, vc: self)
         }
         .store(in: &cancellabes)
      
      /// handle success login case
      viewModel.$successRegister
         .dropFirst()
         .sink { [weak self] _ in
            guard let self else { return }
            
            self.coordinator?.showMainPage()
         }
         .store(in: &cancellabes)
   }
}
