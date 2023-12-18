//
//  RegisterCoordinator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import UIKit

class RegisterCoordinator: Coordinator {
   var navigationController: UINavigationController
   
   init(navigationController: UINavigationController) {
      self.navigationController = navigationController
   }
   
   func start() {
      let vc = RegisterViewController()
      vc.coordinator = self
      navigationController.pushViewController(vc, animated: true)
   }
   
   func showMainPage() {
      print("showMainPage...")
   }
   
}