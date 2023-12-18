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
      print("showMainPage...")
   }
   
   
   //    func showSecondController(with title: String) {
   //        let secondCoordinator = SecondCoordinator(navigationController: navigationController, title: title)
   //        secondCoordinator.start()
   //    }
   
}
