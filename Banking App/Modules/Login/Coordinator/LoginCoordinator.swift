//
//  LoginCoordinator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import UIKit

class LoginCoordinator: Coordinator {
   var navigationController: UINavigationController
   
   init(navigationController: UINavigationController) {
      self.navigationController = navigationController
   }
   
   func start() {
      let vc = LoginViewController()
      vc.coordinator = self
      navigationController.pushViewController(vc, animated: true)
   }
   
   func showMainPage() {
      let coordinator = HomeCoordinator(navigationController: navigationController)
      coordinator.start()
   }
   
   func showRegisterPage() {
      let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
      registerCoordinator.start()
   }
   
   func changeRootToLogin() {
      let viewController = LoginViewController()
      viewController.coordinator = self
      navigationController = UINavigationController(rootViewController: viewController)
      
      UIApplication.setRootViewController(navigationController)
   }
   
   deinit {
      print("Deinited: LoginCoordinator")
   }
}
