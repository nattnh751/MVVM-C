//
//  AppCoordinator.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/25/21.
//

import Foundation
class AppCoordinator : Coordinator {
 let window: UIWindow?
 
 lazy var rootViewController: UINavigationController = {
     return UINavigationController(rootViewController: UIViewController())
 }()
 
 let apiClient: ApiClient = {
     let configuration = URLSessionConfiguration.default
     configuration.httpAdditionalHeaders = ["Content-Type": "application/json; charset=utf-8"]
     let apiClient = ApiClient(configuration: configuration)
     return apiClient
 }()

 init(window: UIWindow?) {
     self.window = window
 }

 override func start() {
     guard let window = window else {
         return
     }

     window.rootViewController = rootViewController
     window.makeKeyAndVisible()
 }

 override func finish() {

 }

}
