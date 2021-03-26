//
//  AppCoordinator.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/25/21.
//

import Foundation
import UIKit

class AppCoordinator : Coordinator {
  
 let window: UIWindow?

 init(window: UIWindow?) {
     self.window = window
 }

 override func start() {
    let newwsCoordinator = NewsCoordinator(delegate: self)
    addChildCoordinator(newwsCoordinator)
    newwsCoordinator.start()
 }

 override func finish() {
    
 }

}
extension AppCoordinator : NewsDelegate {
  func viewControllerCreated(_ viewController : UINavigationController) {
    guard let window = window else {
         return
    }
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  func didFinish(from coordinator: NewsCoordinator) {
    removeChildCoordinator(coordinator)
  }
}
