//
//  SearchCoordinator.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/25/21.
//

import Foundation
class SearchCoordinator: Coordinator {
  
    // MARK: - Properties
  
    let rootViewController: UITabBarController

    let rootNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.tabBarItem = .search
        return navVC
    }()

    let storyboard = UIStoryboard(named: "Search")

    let apiClient: ApiClient

    // MARK: VM / VC's
    lazy var searchViewModel: SearchInputViewModel! = {
        let viewModel = SearchViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()

    var locationSearchViewModel: LocationSearchViewModel {
        let placeService = PlaceApiService(apiClient: apiClient, plistClient: PlistClient())
        let viewModel = LocationSearchViewModel(service: placeService)
        viewModel.coordinatorDelegate = self
        return viewModel
    }

    // MARK: - Coordinator
    init(rootViewController: UITabBarController, apiClient: ApiClient) {
        self.rootViewController = rootViewController
        self.apiClient = apiClient
    }

    override func start() {
        let searchVC: SearchViewController = storyboard.instantiateViewController()
      searchVC.viewModel = searchViewModel
        rootNavigationController.setViewControllers([searchInputVC], animated: false)

        rootViewController.setViewControllers([rootNavigationController], animated: false)
    }

    override func finish() {
        // Clean up any view controllers. Pop them of the navigation stack for example.
        delegate?.didFinish(from: self)
    }
    
}
