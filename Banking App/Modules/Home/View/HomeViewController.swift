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
   private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      layout.minimumInteritemSpacing = 12
      layout.minimumLineSpacing = 0
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.isPagingEnabled = true
      collectionView.showsHorizontalScrollIndicator = false
      collectionView.backgroundColor = .clear
      collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      
      collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: "cell")
      
      return collectionView
   }()
   
   let pageControl: UIPageControl = {
      let pageControl = UIPageControl()
      pageControl.translatesAutoresizingMaskIntoConstraints = false
      pageControl.currentPageIndicatorTintColor = UIColor.blue
      pageControl.pageIndicatorTintColor = UIColor.lightGray
      return pageControl
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
      viewModel.getCards()
   }
   
   deinit {
      print("Deinited: HomeViewController")
   }
   
}

// MARK: - Setup
extension HomeViewController {
   private func setupUI() {
      view.backgroundColor = .secondarySystemBackground
      
      setupCard()
      self.view.addSubview(logoutButton)
      
      self.logoutButton.addAction(UIAction(handler: { [weak self] action in
         guard let self else { return }
         /// validate fields and continue
         self.viewModel.logout()
      }), for: .touchUpInside)
      
      self.addCardButton.addAction(UIAction(handler: { [weak self] action in
         guard let self else { return }
         
         self.viewModel.createNewCard(
            name: "Kanan Abilzada", balance: Float.random(in: 0...1000),
            expirationDate: "\(Int.random(in: 1...12))/\(Int.random(in: 1...30))", pan: CardGenerator.generateRandomCardNumber(),
            cvv: "\(Int.random(in: 100...999))"
         )
         
      }), for: .touchUpInside)
      
      setConstraints()
   }
   
   private func setupCard() {
      self.view.addSubview(actionsStackView)
      self.view.addSubview(collectionView)
      self.view.addSubview(addCardButton)
      self.view.addSubview(pageControl)
      
      pageControl.currentPage = 0
      
      actionsStackView.addArrangedSubview(addCardButton)
      actionsStackView.addArrangedSubview(removeCardButton)
      actionsStackView.addArrangedSubview(transferCardButton)
   }
   
   private func setConstraints() {
      NSLayoutConstraint.activate([
         collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
         collectionView.heightAnchor.constraint(equalToConstant: 210),
         
         actionsStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
         actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
         actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
         
         logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
         logoutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         
         // PageControl constraints
         pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10)
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
      
      viewModel.$cards
         .filter { !$0.isEmpty }
         .sink { [weak self] cardList in
            guard let self else { return }
            
            self.pageControl.numberOfPages = cardList.count
            self.collectionView.reloadData()
         }
         .store(in: &cancellabes)
   }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.viewModel.cards.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CardViewCell else {
         fatalError()
         
         return UICollectionViewCell()
      }
      
      myCell.card = viewModel.cards[indexPath.row]
      
      return myCell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return collectionView.bounds.size
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let width = scrollView.frame.width
      let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
      pageControl.currentPage = currentPage
   }
}

extension HomeViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("User tapped on item \(indexPath.row)")
   }
}
