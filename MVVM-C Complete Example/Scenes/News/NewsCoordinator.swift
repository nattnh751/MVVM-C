//
//  SearchCoordinator.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/25/21.
//

import Foundation
import UIKit
protocol NewsDelegate  {
  func viewControllerCreated(_ viewController : UINavigationController)
  func didFinish(from coordinator: NewsCoordinator)
}
class NewsCoordinator: Coordinator {
  
    // MARK: - Properties
  
  let delegate : NewsDelegate

  let storyboard = UIStoryboard(name: "News", bundle: nil)

  // MARK: VM / VC's
  lazy var newsViewModel: NewsViewModel! = {
      let viewModel = NewsViewModel()
//        viewModel.coordinatorDelegate = self
      return viewModel
  }()
  
  let rootNavigationController: UINavigationController = {
      return UINavigationController()
  }()

    // MARK: - Coordinator
  init(delegate : NewsProtocol) {
    self.delegate = delegate
  }

    override func start() {
      let newsVC: NewsViewController = storyboard.instantiateViewController(identifier: "News")
//      newsVC.viewModel = newsViewModel
      rootNavigationController.setViewControllers([newsVC], animated: false)
      delegate.viewControllerCreated(rootNavigationController)
    }

    override func finish() {
        // Clean up any view controllers. Pop them of the navigation stack for example.
//        delegate?.didFinish(from: self)
    }
    
}

extension NewsCoordinator {
    
    func goToWebsite(from controller: UIViewController) {
      //.for same scene
//        let viewController: LocationSearchViewController = storyboard.instantiateViewController()
//        viewController.viewModel = locationSearchViewModel
//        controller.present(viewController, animated: true, completion: nil)
    }
    
    func goToFavorites(from controller: UIViewController) {
      // for different scene
//        let searchCoordinator = SearchCoordinator(rootViewController: rootNavigationController, apiClient: apiClient, searchInput: validatedState)
//        searchCoordinator.delegate = self
//        addChildCoordinator(searchCoordinator)
//        searchCoordinator.start()
    }
  
}
