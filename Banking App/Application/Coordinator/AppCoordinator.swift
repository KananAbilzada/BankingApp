//
//  AppCoordinator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import UIKit

class AppCoordinator: Coordinator {
   var navigationController: UINavigationController
   let window: UIWindow
   
   init(window: UIWindow, navigationController: UINavigationController) {
      self.window               = window
      self.navigationController = navigationController
   }
   
   func start() {
      window.rootViewController =  navigationController
      window.makeKeyAndVisible()
   }
   
   func showLogin() {
      let coordinator = LoginCoordinator(navigationController: navigationController)
      coordinator.start()
   }
   
   func showHome() {
      let coordinator = HomeCoordinator(navigationController: navigationController)
      coordinator.start()
   }
}
