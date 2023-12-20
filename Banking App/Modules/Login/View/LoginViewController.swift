//
//  ViewController.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
   // MARK: - Properties
   var coordinator: LoginCoordinator?
   private var cancellabes: Set<AnyCancellable> = .init()
   private var viewModel = LoginViewModelImpl()
   
   // MARK: - Views
   private lazy var emailField: CustomTextFieldView = .init()
   private lazy var passwordField: CustomTextFieldView = .init()
   
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
      imageView.image = .init(named: ImageNames.loginBackground.rawValue)
      imageView.contentMode = .scaleAspectFit
      
      return imageView
   }()
   
   private lazy var notHaveAccountButton: UIButton = {
      let button = UIButton()
      button.setTitle("Not have Account? Register", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitleColor(.systemGray, for: .normal)
      button.titleLabel?.font = .boldSystemFont(ofSize: 14)

      return button
   }()
   
   private lazy var loginButton: CustomButton = {
      let button = CustomButton()
      button.setButtonTitle("Confirm")
      button.setButtonBackgroundColor(.systemBlue)
      
      return button
   }()
   
   // MARK: - Main methods
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      title = "Login"
      
      setupUI()
      subscribeToViewModel()
   }
   
   deinit {
      print("Deinited: LoginViewController")
   }
}

// MARK: - Setup
extension LoginViewController {
   private func setupUI() {
      view.backgroundColor = .white
      
      self.view.addSubview(headerImage)
      
      setupFields()
      setupButton()
      setConstraints()
   }
   
   private func setupButton() {
      self.view.addSubview(loginButton)
      self.view.addSubview(notHaveAccountButton)
      
      self.loginButton.addAction(UIAction(handler: { [weak self] action in
         guard let self else { return }
         /// validate fields and continue
         self.viewModel.checkFields(
            email: self.emailField.textField.text!,
            password: self.passwordField.textField.text!
         )
      }), for: .touchUpInside)
      
      self.notHaveAccountButton.addAction(UIAction(handler: { [weak self] action in
         guard let self else { return }
         self.coordinator?.showRegisterPage()
      }), for: .touchUpInside)
   }
   
   private func setupFields() {
      emailField.titleLabel.text = "Email"
      emailField.textField.keyboardType = .emailAddress
      emailField.leftImage = .init(named: ImageNames.email.rawValue)
      emailField.textField.placeholder = "example@gmail.com"
      
      passwordField.titleLabel.text = "Password"
      passwordField.textField.keyboardType = .default
      passwordField.textField.isSecureTextEntry = true
      passwordField.leftImage = .init(named: ImageNames.password.rawValue)
      passwordField.textField.placeholder = "******"
      
      fieldsStackView.addArrangedSubview(emailField)
      fieldsStackView.addArrangedSubview(passwordField)
      
      self.view.addSubview(fieldsStackView)
   }
   
   private func setConstraints() {
      let height = UIScreen.main.bounds.height
      
      NSLayoutConstraint.activate([
         headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         headerImage.widthAnchor.constraint(equalToConstant: 300),
         headerImage.heightAnchor.constraint(equalToConstant: 200),
         headerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: height / 8),
         
         fieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         fieldsStackView.topAnchor.constraint(equalTo: headerImage.bottomAnchor),
         fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         
         loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         loginButton.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 30),
         loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         loginButton.heightAnchor.constraint(equalToConstant: 60),
         loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         
         
         notHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         notHaveAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
      ])
      
   }
}

// MARK: - Observe ViewModel
extension LoginViewController {
   private func subscribeToViewModel() {
      /// validation of submit button clicked to continue
      viewModel.$errors
         .filter { !$0.isEmpty }
         .sink { [weak self] errors in
            guard let self else { return }
            print("show errors \(errors)")
            
            errors.forEach { key, value in
               if key == .email {
                  self.emailField.showError(message: value)
               }
               
               if key == .password {
                  self.passwordField.showError(message: value)
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
      viewModel.$successLogin
         .dropFirst()
         .sink { [weak self] _ in
            guard let self else { return }
            
            self.coordinator?.showMainPage()
         }
         .store(in: &cancellabes)
   }
}
