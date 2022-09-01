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
  
  let apiServer: ApiServer = {
      let apiClient = ApiServer()
      return apiClient
  }()
  
  override func start() {
    let newwsCoordinator = NewsCoordinator(delegate: self, apiServer: apiServer)
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
