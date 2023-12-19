//
//  HomeCoordinator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import Foundation

import UIKit

class HomeCoordinator: Coordinator {
   var navigationController: UINavigationController
   
   init(navigationController: UINavigationController) {
      self.navigationController = navigationController
   }
   
   func start() {
      let homeViewController = HomeViewController()
      homeViewController.coordinator = self
      navigationController = UINavigationController(rootViewController: homeViewController)
      
      UIApplication.setRootViewController(navigationController)
   }
   
   func showLogin() {
      let loginViewController = LoginCoordinator(navigationController: navigationController)
      loginViewController.changeRootToLogin()
   }
   
}
