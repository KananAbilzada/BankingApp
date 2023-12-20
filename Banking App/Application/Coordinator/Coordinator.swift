//
//  Coordinator.swift
//  Banking App
//
//  Created by Kanan Abilzada on 17.12.23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
