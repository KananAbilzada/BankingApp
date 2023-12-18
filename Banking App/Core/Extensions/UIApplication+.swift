//
//  UIApplication+.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import UIKit

extension UIApplication {
   static func setRootViewController(_ viewController: UIViewController) {
      guard let window = UIApplication.shared.windows.first else {
         return
      }
      
      window.rootViewController = viewController
      
      // Optional: You may want to add animations or transitions when changing the root view controller.
      UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
      /// transitionFlipFromRight
   }
   
   static func takeAppVersion() -> String {
      let dictionary = Bundle.main.infoDictionary!
      let version = dictionary["CFBundleShortVersionString"] as! String
      //        let build = dictionary["CFBundleVersion"] as! String
      return "\(version)"
   }
}
