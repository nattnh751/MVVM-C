//
//  SceneDelegate.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import UIKit

@available(iOS 13.0,*)
class SceneDelegate : UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var appCoordinator: AppCoordinator!
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    if let windowScene = scene as? UIWindowScene {
      self.window = UIWindow(windowScene: windowScene)
      appCoordinator = AppCoordinator(window: window)
      appCoordinator.start()
    }
  }
}
