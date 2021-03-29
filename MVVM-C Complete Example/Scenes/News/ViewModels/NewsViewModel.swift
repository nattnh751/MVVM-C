//
//  NewsViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsViewModelViewModelType { //stuff that is used by the view controller should be declared here, anything else should be fileprivate in the actual class definition
  //data
  var newsCells: Observable<[ArticleCellType]> { get }
  // Events
  func start(_ delegate : ArticleCellViewModelViewControllerDelegate)

  func didSelectArticle(_ viewController : UIViewController, article : Article)
  
  func didFavoriteArticle(_ viewController : UIViewController, article : Article)
  
  func didRemoveFavoriteArticle(_ viewController : UIViewController, article : Article)

}

protocol NewsViewModelCoordinatorDelegate { //call back to the coordinator, any time the view controller wants to nabvigate it should go through its delegate and then here
  func didSelectArticle(_ viewController : UIViewController, article : Article, viewModel : NewsViewModel)
}

class NewsViewModel {
  var coordinatorDelegate : NewsViewModelCoordinatorDelegate?
  private let cells = BehaviorRelay<[ArticleCellType]>(value: [])
  let disposeBag = DisposeBag()
  let apiServer: ApiServer
  
  init(_ apiServer: ApiServer) {
    self.apiServer = apiServer
  }
  
  func start(_ delegate : ArticleCellViewModelViewControllerDelegate) {
    apiServer.getArticles().subscribe(
        onNext: { [weak self] articles in
            guard articles.count > 0 else {
                self?.cells.accept([.empty])
                return
            }

            self?.cells.accept(articles.compactMap { .normal(cellViewModel: ArticleCellViewModel(article: $0 , delegate)) }) //need to add a view model
        },
        onError: { [weak self] error in
            self?.cells.accept([
                .error(
                    message: "Loading failed, check network connection"
                )
            ])
        }
    )
    .disposed(by: disposeBag)
  }
}

extension NewsViewModel : NewsViewModelViewModelType {
  var newsCells: Observable<[ArticleCellType]> {
    get {
      return cells.asObservable()
    }
  }
  
  func didSelectArticle(_ viewController : UIViewController, article : Article) {
    coordinatorDelegate?.didSelectArticle(viewController, article: article, viewModel: self)
  }
  
  func didFavoriteArticle(_ viewController : UIViewController, article : Article) {
      for item in self.cells.value {
        switch item {
        case .normal(let articleViewModel):
          if(articleViewModel.article.id == article.id) {
            updateFavorite(articleViewModel, true)
          }
        case .error(let message):
          print(message)
        case .empty:
          print("empty")
        }
      }
  }
  
  func didRemoveFavoriteArticle(_ viewController : UIViewController, article : Article) {
    //TODO: remove favorite, update data
    for item in self.cells.value {
      switch item {
      case .normal(let articleViewModel):
        if(articleViewModel.article.id == article.id) {
          updateFavorite(articleViewModel, false)
        }
      case .error(let message):
        print(message)
      case .empty:
        print("empty")
      }
    }
  }
  
  fileprivate func updateFavorite(_ vm : ArticleCellViewModel, _ isFavorite : Bool) {
    var art = vm.article
    var oldItemsWithoutNewItem = self.cells.value.filter { item -> Bool in
      switch item {
      case .normal(let articleViewModel):
        if(articleViewModel.article.id != art.id) {
          return true
        }
      case .error(_):
        return false
      case .empty:
        return false
      }
      return false
    }
    art.favorite = isFavorite
    oldItemsWithoutNewItem.append(.normal(cellViewModel: ArticleCellViewModel(article: art , vm.viewControllerDelegate)))
    self.cells.accept(oldItemsWithoutNewItem)
  }
}
