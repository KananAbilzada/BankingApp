//
//  HomeViewController.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
   // MARK: - Properties
   var coordinator: HomeCoordinator?
   private var cancellabes: Set<AnyCancellable> = .init()
   private var viewModel = HomeViewModelImpl()
   
   // MARK: - Views
   private lazy var cardView: CardView = {
      let view = CardView()
      view.setCardNumber("**** **** **** 1234")
      view.setCardUser("Kanan Abilzada")
      view.setValidDate("12/26")
      
      return view
   }()
   
   private lazy var actionsStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.alignment = .center
      stackView.axis = .horizontal
      stackView.distribution = .equalCentering
      
      return stackView
   }()
   
   private lazy var addCardButton: ActionButton = {
      let view = ActionButton()
      view.iconView.image = .init(named: ImageNames.add.rawValue)
      view.title.text = "Add"
      
      return view
   }()
   
   private lazy var removeCardButton: ActionButton = {
      let view = ActionButton()
      view.iconView.image = .init(named: ImageNames.rubbishBin.rawValue)
      view.title.text = "Remove"
      
      return view
   }()
   
   private lazy var transferCardButton: ActionButton = {
      let view = ActionButton()
      view.iconView.image = .init(named: ImageNames.transfer.rawValue)
      view.title.text = "Transfer"
      
      return view
   }()
   
   private lazy var logoutButton: UIButton = {
      let button = UIButton()
      button.setTitle("Logout", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitleColor(.red, for: .normal)
      button.titleLabel?.font = .boldSystemFont(ofSize: 15)

      return button
   }()
   
   // MARK: - Main methods
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      title = "Home"
      
      setupUI()
      subscribeToViewModel()
   }
}

// MARK: - Setup
extension HomeViewController {
   private func setupUI() {
      view.backgroundColor = .secondarySystemBackground
      
      setupCard()
      self.view.addSubview(logoutButton)
      self.logoutButton.addAction(UIAction(handler: { action in
         /// validate fields and continue
         self.viewModel.logout()
      }), for: .touchUpInside)
     
      setConstraints()
   }
   
   private func setupCard() {
      self.view.addSubview(actionsStackView)
      self.view.addSubview(cardView)
      self.view.addSubview(addCardButton)
      
      actionsStackView.addArrangedSubview(addCardButton)
      actionsStackView.addArrangedSubview(removeCardButton)
      actionsStackView.addArrangedSubview(transferCardButton)
   }
   
   private func setConstraints() {
      NSLayoutConstraint.activate([
         cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
         cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
         cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
         cardView.heightAnchor.constraint(equalToConstant: 210),
         
         actionsStackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30),
         actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
         actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
         
         logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
         logoutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      ])
   }
}

// MARK: - Observe ViewModel
extension HomeViewController {
   private func subscribeToViewModel() {
      viewModel.$showLogin
         .sink { [weak self] value in
            if value {
               self?.coordinator?.showLogin()
            }
         }
         .store(in: &cancellabes)
   }
}
