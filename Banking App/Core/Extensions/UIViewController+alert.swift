//
//  UIViewController+alert.swift
//  Banking App
//
//  Created by Kanan Abilzada on 18.12.23.
//

import UIKit

extension UIViewController {
   func runInMainThread (completetion: @escaping () -> ()) {
      DispatchQueue.main.async {
         completetion()
      }
   }
   
   func performSegueToReturnBack()  {
      if let nav = self.navigationController {
         nav.popViewController(animated: true)
      } else {
         self.dismiss(animated: true, completion: nil)
      }
   }
}

extension UIViewController {
   func informationAlert(title: String, message: String, vc: UIViewController) {
      let alertXalert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
      let acClose = UIAlertAction(title: "Ok", style: .default, handler:
                                    { (UIAlertAction) -> Void in
         
         vc.dismiss(animated: true, completion: nil)
         
      } )
      alertXalert.addAction(acClose)
      vc.present(alertXalert, animated: true, completion: nil)
   }
}

extension UIViewController {
   var isModal: Bool {
      if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
         return false
      } else if presentingViewController != nil {
         return true
      } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
         return true
      } else if tabBarController?.presentingViewController is UITabBarController {
         return true
      } else {
         return false
      }
   }
}
